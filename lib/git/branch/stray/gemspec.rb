module Git
  module Branch
    module Stray
      PIM = <<~"PIM".freeze

        The following aliases are recommended for \033[1mgit branch--stray\33[0m:

        \tgit config --global \033[1malias.bls\033[0m branch--list--stray
        \tgit config --global \033[1malias.bds\033[0m branch--delete--stray

        The following is an optional convenience alias:

        \tgit config --global \033[1malias.blr\033[0m branch--list--recent

        Thanks for using \033[1mgit branch--stray\033[0m ... the ultimate housekeeping tool for git branches!

      PIM
    end
  end
end
