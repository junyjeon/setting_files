# Claude Code 전역 설정 수동 동기화

이 디렉터리는 현재 기기의 `~/.claude` 전체 백업이 아니다. 여러 기기에서 공유해도 안전한 사용자 설정만 선별한 수동 동기화 원본이다.

저장소 루트의 기존 `.claude/`는 프로젝트 전용 설정이므로 이 디렉터리와 합치지 않는다.

## 포함 범위

| 저장소 파일 | 적용 위치 | 비고 |
|---|---|---|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` | 전역 작업 지침 |
| `settings.shared.json` | `~/.claude/settings.json`에 병합 | 일반 환경설정 |
| `settings.optional.json` | 검토 후 선택 병합 | 자동 권한, 플러그인 및 CodeGraph 의존 설정 |
| `agents/*.md` | `~/.claude/agents/` | 기기 독립적인 개인 에이전트 |
| `rules/*.md` | `~/.claude/rules/` | 개인 전역 규칙 |
| `skills/*` | `~/.claude/skills/` | 개인 스킬 |

현재 `~/.claude/settings.json`의 모델 값에는 터미널 ANSI 문자열로 보이는 `[1m]`이 붙어 있었다. 공유본에서는 의도한 값으로 판단되는 `opus`로 정규화했다.

## 다른 기기에 적용

아래 명령은 저장소 루트에서 실행한다. 먼저 차이를 검토한다.

```sh
diff -u "$HOME/.claude/CLAUDE.md" claude-home/CLAUDE.md || true
diff -ru "$HOME/.claude/agents" claude-home/agents || true
diff -ru "$HOME/.claude/rules" claude-home/rules || true
```

기존 전역 지침과 설정을 백업한다.

```sh
mkdir -p "$HOME/.claude"
cp "$HOME/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md.before-setting-files"
cp "$HOME/.claude/settings.json" "$HOME/.claude/settings.json.before-setting-files"
```

새 기기에 해당 파일이 아직 없다면 해당 `cp` 백업 명령만 건너뛴다.

공유 파일을 적용한다. `rsync --delete`를 사용하지 않으므로 대상 기기에만 있는 파일은 삭제되지 않는다.

```sh
cp claude-home/CLAUDE.md "$HOME/.claude/CLAUDE.md"
mkdir -p "$HOME/.claude/agents" "$HOME/.claude/rules" "$HOME/.claude/skills"
rsync -av claude-home/agents/ "$HOME/.claude/agents/"
rsync -av claude-home/rules/ "$HOME/.claude/rules/"
rsync -av claude-home/skills/ "$HOME/.claude/skills/"
```

공통 설정은 기존 `settings.json`에 병합한다. 저장소 값이 같은 키의 기존 값을 대체하지만, 저장소에 없는 hooks와 로컬 설정은 유지한다.

```sh
jq -s '.[0] * .[1]' \
  "$HOME/.claude/settings.json" \
  claude-home/settings.shared.json \
  > /tmp/claude-settings.merged.json
jq empty /tmp/claude-settings.merged.json
cp /tmp/claude-settings.merged.json "$HOME/.claude/settings.json"
```

새 기기에 `settings.json`이 없다면 먼저 `{}`로 된 파일을 만든다.

`settings.optional.json`에는 `defaultMode: auto`, 자동 권한 프롬프트 생략, CodeGraph MCP 허용 및 플러그인 활성화 상태가 들어 있다. 내용을 확인하고 필요한 도구와 플러그인이 설치된 기기에서만 같은 방식으로 추가 병합한다. 이 파일은 플러그인 자체를 설치하지 않는다.

## 현재 기기에서 저장소로 갱신

`~/.claude` 전체를 재귀 복사하지 않는다. 수정한 개인 파일만 정확한 경로로 하나씩 `claude-home/`에 복사하고 `git diff -- claude-home`으로 검토한다.

`settings.json`은 통째로 복사하지 않고 다음 파일을 각각 갱신한다.

- 일반 UI·모델·알림 설정: `settings.shared.json`
- 권한·플러그인·도구 의존 설정: `settings.optional.json`
- hooks: 플러그인 설치 과정에서 다시 생성하며 이 저장소에 복사하지 않음

## 의도적으로 제외한 항목

- 인증정보, API 키, 토큰, 로컬 환경변수
- `history.jsonl`, sessions, projects, session-data, logs, cache, telemetry, backups
- `plugins/` 캐시와 Everything Claude Code가 관리하는 hooks, scripts, MCP 설정
- 라이선스를 확인하지 않은 알림음 MP3
- 외부 저장소를 가리키는 `rules/한국어` 심링크
- 로컬 경로와 사설 프록시에 의존하는 `claude-caller`, `codex-caller`, `consensus-orchestrator`

제외된 세 에이전트를 공유하려면 `/Users/jun/piix/jun-research`를 환경변수 기반 경로로 바꾸고 SSH·프록시 정보를 별도 로컬 설정으로 분리한 뒤 추가한다.

## 커밋 전 확인

```sh
jq empty claude-home/settings.shared.json
jq empty claude-home/settings.optional.json
rg -n --hidden '(sk-ant-|api[_-]?key|token|password|secret|private[_-]?key)' claude-home
git diff --check
git status --short
```

비밀정보 검사는 후보를 찾는 보조 수단이다. 커밋 전 diff를 직접 확인한다.
