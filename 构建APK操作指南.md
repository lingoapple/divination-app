# GitHub Actions 自动编译 APK 完整操作指南

## 你的算命 App 已经准备好了！

项目文件夹：`divination_app/`

GitHub Actions 编译配置文件已就位：`.github/workflows/build_apk.yml`

---

## 操作步骤（共 5 步）

### 第 1 步：在 GitHub 上创建新仓库

1. 打开 https://github.com/new
2. Repository name 填：`divination-app`
3. 选 **Public**（免费仓库只能选 Public，而且 Actions 免费额度更多）
4. **不要**勾选 "Add a README file"
5. 点击 **Create repository**

### 第 2 步：在本地项目文件夹里初始化 Git

打开 Windows 命令提示符（CMD），依次执行：

```cmd
cd /d "C:\Users\lingo\WorkBuddy AI\2026-11-16-21-40-28\divination_app"

git init
git add .
git commit -m "天机阁算命 App 初始版本"
```

### 第 3 步：推送到 GitHub

把下面的 `你的用户名` 换成你的 GitHub 用户名，然后在 CMD 里执行：

```cmd
git branch -M main
git remote add origin https://github.com/你的用户名/divination-app.git
git push -u origin main
```

> 如果提示登录，输入你的 GitHub 用户名和密码（或 Personal Access Token）。

### 第 4 步：等待自动编译

1. 打开你的仓库页面：`https://github.com/你的用户名/divination-app`
2. 点击上方 **Actions** 标签
3. 你会看到一个叫 **Build Android APK** 的任务正在运行
4. 等待约 **10-15 分钟**，绿色 ✓ 表示编译成功

### 第 5 步：下载 APK

1. 在 Actions 页面点击那次成功的运行记录
2. 页面最下方 **Artifacts** 区域有个 `divination-app-apk` 文件
3. 点击下载，解压后就是 `app-release.apk`
4. 传到手机上安装即可！

---

## 后续更新

每次你修改代码后，只需要：

```cmd
cd /d "C:\Users\lingo\WorkBuddy AI\2026-11-16-21-40-28\divination_app"
git add .
git commit -m "更新说明"
git push
```

GitHub 会自动重新编译，几分钟后就能下载新的 APK。

---

## 常见问题

**Q: push 时提示需要密码？**
A: GitHub 已不支持账号密码，需要用 Personal Access Token。去 GitHub → Settings → Developer settings → Personal access tokens → Generate new token，勾选 repo 权限，把生成的 token 当密码用。

**Q: 编译失败了怎么办？**
A: 在 Actions 页面点进去看红色 ✗ 的日志，把错误信息发给我，我帮你修。

**Q: 下载的 APK 文件保留多久？**
A: 目前设置了保留 90 天。

---

## App 功能清单

| 模块 | 说明 |
|------|------|
| 八字命理 | 输入出生日期时辰→四柱八字+五行分析 |
| 紫微斗数 | 复用八字入口 |
| 星座运势 | 十二星座→桃花/财运/事业/健康评分 |
| 塔罗占卜 | 22张大阿卡纳抽牌，过去/现在/未来 |
| 生肖运程 | 选年份→生肖运势+五行+幸运色 |
| 每日运势 | 按星座+日期生成每日运势详解 |
| MBTI测试 | 12题测试→16种人格结果 |
| 起名测名 | 输入姓名→数理打分+分析 |
