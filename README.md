# Money & Banking（Perry Mehrling）

Perry Mehrling（波士顿大学）《Money & Banking》课程的**资源镜像与学习仓库**。这门课也被称为
《Economics of Money and Banking》，以「货币观（The Money View）」为主线，系统讲解货币、
银行、清算体系与全球金融市场的运行逻辑。

本仓库聚合课程的三类核心资源，方便离线学习与长期维护：

- **视频** —— Coursera 课程 + YouTube 完整播放列表
- **讲义** —— 官方站点 22 讲 PDF 幻灯片（已镜像到本仓库 `lectures/pdf/`）
- **维护脚本** —— 一键重新拉取/校验讲义的脚本

## 课程资源入口

| 资源 | 链接 |
| --- | --- |
| Coursera 课程（可免费旁听） | https://www.coursera.org/learn/money-banking |
| YouTube 完整播放列表 | https://www.youtube.com/playlist?list=PLSuwqsAnJMtwZEwkJgHZCod2xP9b7skF5 |
| 官方讲义页（22 讲 PDF） | https://sites.bu.edu/perry/lectures/mb-lectures/ |
| 课程作者主页 | https://sites.bu.edu/perry/ |

## 仓库结构

```
MoneyBanking/
├── README.md                  # 本文件：课程总览与资源入口
├── lectures/
│   ├── README.md              # 22 讲索引（讲次 · 标题 · 讲义 PDF · 官方讲义页）
│   └── pdf/                   # 22 讲 PDF 讲义（官方站点镜像）
└── scripts/
    └── fetch_lectures.sh      # 一键下载/更新 22 讲 PDF（幂等）
```

## 快速使用

```bash
# 重新下载/更新全部 22 讲 PDF（已存在的会跳过）
bash scripts/fetch_lectures.sh
```

讲义索引见 [`lectures/README.md`](lectures/README.md)。

## 课程结构

课程共 **22 讲**，分两大部分（Section）：

- **Section 1（第 1–12 讲）**：货币观基础——货币的四种价格、货币的层级、中央银行与清算、
  联邦基金与最终清算、回购、欧洲美元、做市商与流动性市场、最后贷款人/最后做市商。
  这 12 讲自成一个完整体系，常被其他教授用作独立课程。
- **Section 2（第 13–22 讲）**：货币观的应用——国际货币与外汇、银行与全球流动性、
  直接/间接金融、远期与期货、利率互换、信用违约互换、影子银行与全球金融。

## 版权说明

讲义 PDF 版权归 Perry G Mehrling / Boston University 所有，原始出处为
https://sites.bu.edu/perry/lectures/mb-lectures/ 。本仓库仅作个人学习用途镜像，
请勿用于商业分发；如需引用或转载，请遵循原始版权要求。
