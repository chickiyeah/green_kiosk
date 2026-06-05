# green_kiosk — 키오스크 주문 시스템

카페/매장용 **키오스크 주문 웹 애플리케이션**. 메뉴 조회·주문·결제부터 쿠폰·이벤트·마일리지 적립까지 지원한다. Java Servlet/JSP 기반.

## 기술 스택
- **언어**: Java (Servlet/JSP)
- **DB**: MySQL (JDBC, `DBConnectionMgr`)
- **뷰**: JSP + JS/CSS (`src/main/webapp`)
- **배포**: WAR (Tomcat) · GitHub Actions
- **개발환경**: Eclipse Dynamic Web Project

## 주요 기능
- **메뉴 / 이벤트 메뉴** (menu, eventMenu)
- **주문** (orders)
- **결제** (payments)
- **쿠폰 / 이벤트** (coupon, event)
- **마일리지 적립** (mile)
- **게시판** (board)
- **회원** (user)

## 구조
- `src/main/java/` — 서블릿·도메인 로직 (servlet, user, menu, orders, payments, coupon, event, eventMenu, mile, board, DBconnector)
- `src/main/webapp/` — JSP/JS/CSS, WEB-INF

## 실행
1. Eclipse에서 Dynamic Web Project로 임포트
2. MySQL DB 준비 후 `DBConnectionMgr` 접속 정보 설정 (실제 계정 커밋 금지)
3. Tomcat에 배포

## 메모
- DB 접속 정보는 코드에 하드코딩하지 말고 설정 파일/환경변수로 분리 권장
