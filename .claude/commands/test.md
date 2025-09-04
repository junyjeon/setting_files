# /test - 테스트 코드 생성 및 실행

주어진 코드나 기능에 대한 테스트 코드를 생성하고 실행해.

## 사용법
```
/test [target] [test-type]
```

## 테스트 타입
- `unit` - 단위 테스트
- `integration` - 통합 테스트
- `e2e` - End-to-End 테스트
- `ipc` - IPC 통신 테스트

## 테스트 프레임워크
- **Unit/Integration**: Vitest
- **E2E**: Playwright
- **IPC**: Custom Electron test utils

## 생성 규칙

### 단위 테스트
```typescript
// [feature].test.ts
describe('[Feature]', () => {
  it('should [expected behavior]', () => {
    // Arrange
    // Act
    // Assert
  });
});
```

### IPC 테스트
```typescript
// IPC 핸들러 모킹
// 메시지 전송/수신 검증
// 에러 처리 테스트
```

### E2E 테스트
```typescript
// 실제 Electron 앱 실행
// 사용자 시나리오 테스트
// 스크린샷 캡처
```

## 커버리지 목표
- 단위 테스트: 80% 이상
- 통합 테스트: 60% 이상
- E2E 테스트: 핵심 기능 100%

## 예시
```
/test src/features/memo unit
/test "user login flow" e2e
```