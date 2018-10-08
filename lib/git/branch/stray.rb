require 'git/branch/stray/version'

require 'consenter'

class String # :nodoc:
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize('31')
  end

  def yellow
    colorize('33')
  end
end

module Kernel # :nodoc:
  def git(command)
    `git #{command}`.split($RS).each(&:strip!)
  end
end

module Git # :nodoc:
  module_function

  def local_head_refs
    git('for-each-ref --format="%(refname)" refs/heads')
  end

  def head_refs_for(remote)
    # alternative implementation that requires
    # access to the remote tracking repository
    #
    # git("ls-remote --quiet --refs --heads #{remote}")
    #   .map { |sha_and_ref| sha_and_ref.split(/\s+/).last }
    #
    # but we assume that this utility will mainly be
    # used as part of a "git workflow" that includes
    # regular pruning of remote tracking references,
    # which means we don't have to go over the wire!
    git("for-each-ref --format=\"%(refname)\" refs/remotes/#{remote}")
  end

  def upstream_reference_for(branch)
    git("rev-parse --verify --abbrev-ref #{branch}@{upstream}").first
  end

  def remote_for(branch)
    git("config --local --get branch.#{branch}.remote").first
  end

  def merge_ref_for(branch)
    git("config --local --get branch.#{branch}.merge").first
  end

  def branch_name_from(symbolic_ref)
    # extract the branch name from a given symbolic ref
    # local:  e.g. "refs/heads/master"
    # remote: e.g. "refs/remotes/origin/master"
    symbolic_ref.sub(%r{\Arefs/(heads|remotes/[^/]+)/}, '')
  end

  def stray_branches
    to_branch_name = method(:branch_name_from)

    local_branch_names = local_head_refs.map(&to_branch_name)

    remote_branch_names = Hash.new { |branch_names, remote|
      branch_names[remote] = head_refs_for(remote).map(&to_branch_name)
    }

    local_branch_names.find_all { |local_branch|
      (remote = remote_for(local_branch)) &&
      (merge_ref = merge_ref_for(local_branch)) &&
      (upstream_branch = to_branch_name[merge_ref]) &&
      !remote_branch_names[remote].include?(upstream_branch)
    }
  end

  def delete_stray_branches
    stray_branches.each_consented('Delete stray branch "%s"', inspector: :yellow) do |stray|
      system("git branch -d #{stray}")
      next if $CHILD_STATUS.success?

      Array(stray).each_consented('Delete unmerged branch "%s"', inspector: :red) do |unmerged|
        system("git branch -D #{unmerged}")
      end
    end
  end

  def list_stray_branches
    stray_branches.each do |stray|
      system("git --no-pager branch -vv --list #{stray}")
    end
  end
end
