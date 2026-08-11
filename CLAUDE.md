# setting_files

여러 기기(맥 메인 · PC · Windows MSYS2 · 원격 서버)에서 공유하는 개인 dotfiles 레포다.

## 이 레포의 성격

코드가 아니라 설정 파일 모음이다. 빌드 단계도, 테스트 스위트도 없다.

각 설정은 홈 디렉토리에 **심링크**로 적용한다. 예를 들어 tmux 설정은 다음처럼 건다.

```sh
ln -sf "$(pwd)/.tmux.conf" ~/.tmux.conf   # 한 번만
tmux source-file ~/.tmux.conf             # 즉시 리로드
```

따라서 심링크된 기기에서는 **이 레포의 파일을 고치는 순간 실제로 동작하는 설정이 바뀐다.** 변경은 신중히 한다.

## 구성

- `.tmux.conf` — tmux 설정. prefix는 백틱(`` ` ``). 적용·리로드법과 키 목록은 파일 상단 주석에 정리돼 있다.
- `.zshrc` — zsh 설정(oh-my-zsh 기반). 맥·리눅스용.
- `.zshrc_for_MYSYS2` — Windows MSYS2 전용 zsh 변형.
- `.vimrc` — vim 설정.
- `.vscode/` — VS Code 키바인딩·C/C++ 속성·launch·tasks.
- `.gitmessage.txt` — 커밋 메시지 템플릿. (`.gitmessage(26-01-28).txt`는 날짜 백업)
- `.claude/` — Claude Code용 commands(`clean`·`optimize`·`test`)·output-style·`play-mp3.ps1`.

## 작업 규칙

- **적용 범위**: 변경은 심링크된 기기에서만 반영된다. 새 기기에는 `ln -sf`로 연결해야 한다.
- **검증(테스트 대신)**:
  - tmux: `tmux source-file ~/.tmux.conf` (또는 세션 안에서 `` ` `` + `r`)
  - zsh: `zsh -n .zshrc`로 문법만 검사
  - vim: `vim -u .vimrc +q`로 에러 확인
- **prefix·키바인딩 변경**은 여러 기기의 손버릇에 직접 영향을 준다. 바꾸면 `.tmux.conf` 헤더 주석의 키 목록도 함께 갱신한다.
- **기기별로 갈리는 설정**은 `.zshrc` vs `.zshrc_for_MYSYS2`처럼 파일을 분리한다. 한 파일에 `if [[ OS ... ]]` 분기를 쌓지 않는다.

## 커밋

- `.gitmessage.txt` 형식을 따른다: `type(scope): summary`, 키워드 행, 본문에 '왜', 한국어.
- 한 논리적 변경 = 한 커밋.

## 주의

- 공개 레포다. 토큰·API 키·비밀번호 같은 비밀정보를 커밋하지 않는다.
