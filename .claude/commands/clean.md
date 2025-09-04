# /clean - Clean Architecture 컴포넌트 생성

Clean Architecture 패턴에 맞는 새로운 기능 컴포넌트를 생성해.

## 사용법
```
/clean [feature-name] [description]
```

## 생성 구조
1. **Domain Layer**
   - `src/backend/domain/[feature]/entities/`
   - `src/backend/domain/[feature]/value-objects/`
   - `src/backend/domain/[feature]/events/`

2. **Application Layer**
   - `src/backend/application/[feature]/use-cases/`
   - `src/backend/application/[feature]/ports/`

3. **Infrastructure Layer**
   - `src/backend/infrastructure/[feature]/repositories/`
   - `src/backend/infrastructure/[feature]/adapters/`

4. **Interface Layer**
   - `src/backend/interfaces/ipc/[feature]/handlers.ts`
   - `src/features/[feature]/components/`
   - `src/features/[feature]/hooks/`

## 생성 규칙
- TypeScript 타입 정의 필수
- 각 레이어 간 의존성 규칙 준수
- IPC 통신 컨트랙트 자동 생성
- 기본 테스트 파일 포함

## 예시
```
/clean user-settings "사용자 설정 관리 기능"
```

위 명령어 실행 시:
- UserSettings 엔티티 생성
- UserSettingsRepository 인터페이스 정의
- UpdateUserSettings 유스케이스 구현
- IPC 핸들러 및 프리로드 브릿지 설정
- React 컴포넌트 및 훅 생성