# Git Convention

요약판이다. 브랜치 전략·PR·머지·태그를 포함한 상세판은
`~/projects/agentic-boilerplate/.claude/rules/깃컨벤션.md`에 있다.

## 원자적 커밋

하나의 논리적 변경 = 하나의 커밋.
예를들어 인증·결제·이메일 기능을 한 커밋에 묶지 않는다.
의존하는 파일은 같은 커밋에 넣는다.


## 메시지 형식

```
<type>(<scope>): <summary>

<키워드 · 키워드>

<body>

<footer>
```

- **Type**: feat · fix · hotfix · refactor · docs · test · chore · perf · style · ci
- **Scope** (선택): 단일 모듈이면 사용, 여러 영역이면 생략
- **Summary**: 50자 이내, 마침표 없음. 문제나 결과를 쓴다 (구현은 Body에). squash merge의 `(#PR번호)` 접미사는 유지
- **키워드**: 다루는 내용을 · 로 나열. 식별자와 개념 혼용
- **Body**: 왜 변경했는지 설명. 연결어로 관계 명시. 72자 줄바꿈
- **Footer**:
  - `Review: passed/skipped/manual` — /code-review 결과
  - `Closes #123` — 이슈 닫기
  - `BREAKING CHANGE: 설명` — 호환성 깨는 변경
  - `Co-Authored-By: Claude <noreply@anthropic.com>` — AI 협업 명시


## 실전 예시

```
fix(editor): 머신 텍스트 개행이 선택 전후로 달라지는 문제 수정

border · outline · MachineItem · 텍스트 레이아웃

border는 콘텐츠 영역을 줄여 작은 머신에서 텍스트 줄바꿈이
선택 전후로 달라지는 문제가 있었다. 반면 outline은 레이아웃에
영향을 주지 않으므로 일관된 텍스트 렌더링을 보장한다.

Co-Authored-By: Claude <noreply@anthropic.com>
```


## 우선순위

프로젝트에 `.gitmessage.txt`가 있으면 그 형식을 우선 따른다. 글로벌 템플릿은 `~/.gitmessage.txt`에 두고 `git config --global commit.template ~/.gitmessage.txt`로 적용한다.


## 체크리스트

- [ ] 타입 올바름
- [ ] Summary가 문제나 결과를 쓰고 있음
- [ ] 키워드 행 작성
- [ ] 본문에 '왜' 설명 + 연결어 사용
