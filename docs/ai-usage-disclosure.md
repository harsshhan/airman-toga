# AI Usage Disclosure

## 1. Did you use AI tools?

Yes. AI tools were used as development assistants for planning, UI design assistance, implementation guidance, and architecture discussions.

Tools used:

- Figma AI
- Antigravity IDE
- Claude
- ChatGPT

---

## 2. What did AI help generate?

- Initial UI design ideas and layouts using Figma AI
- Architecture planning and workflow discussions
- Model structures and mock data suggestions
- Guidance for implementing state management, local storage, and reusable components
- Documentation assistance

---

## 3. What was manually reviewed or changed?

All generated suggestions were manually reviewed before implementation.

Manual work included:

- Folder structure organization
- UI implementation in Flutter
- State flow decisions
- Provider integration
- Reusable widget creation
- Business logic adjustments
- Bug fixes and design refinements

---

## 4. Which AI suggestion was rejected and why?

Some generated suggestions introduced unnecessary complexity for a 24-hour assessment (additional abstraction layers and excessive file separation). These were simplified to maintain development speed while keeping scalability.

---

## 5. Which part of the project did you personally design?

- Feature organization
- Provider → Repository → Service flow
- Local storage decisions
- Dashboard and screen composition
- Application navigation flow
- Integration between modules

---

## 6. Which part are you least confident about?

Future backend synchronization behavior and production-scale sync conflict handling would need further refinement with a real backend.