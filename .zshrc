# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR="nvim"
export VISUAL="$EDITOR"


export PATH=$PATH:~/.o3-cli/bin
export PATH=$PATH:$(go env GOPATH)/bin
export VAULT_ADDR="https://vault.s.o3.ru:8200"

export GOPATH="$HOME/go"; export GOROOT="$HOME/.go"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g
export CGO_CFLAGS='-O2 -g -DHAVE_STRCHRNUL=1'

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Запускает виртуальную машину для работы docker
alias colimastart="colima start --profile ozon --cpu 2 --disk 60"
# Останавливает виртуальную машину для docker
alias colimastop="colima stop ozon"
# Перезапускает
alias colimarestart="colima restart ozon --force"

alias vim=nvim
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
