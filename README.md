# 하면서 배운 것들

#### 🥑 22-12-23

[1] No Storyboard 설정
- Main 지우고, info.plist에 storyboard name 행 지우기
- SceneDelegate.swift에 root view 설정
```
guard let scene = scene as? UIWindowScene else { return }
window = UIWindow(windowScene: scene)
window?.makeKeyAndVisible()
window?.backgroundColor = .systemBackground
window?.rootViewController = LoginViewController()
```
[2] equlToSystemSpacingAfter
- 출발지점 => 도착지점으로 생각
- multiplier의 1은 8과 같다
```
view.trailingAnchor.constraint(equalToSystemSpacingAfter: someView.trailingAnchor, multiplier: 1).isActive = true
```

[3] UITextField Delegate 메소드
- textFieldShouldReturn
- textFieldShouldEndEditing
- textFieldDidEndEditing

[4] intrinsicContentSize
- 뷰의 default width | height
