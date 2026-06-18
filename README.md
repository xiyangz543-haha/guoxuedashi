# 国学大师

基于 **殆知阁古籍库 v2**（15,473 部古籍）的国学顾问型 AI Skill。

全库古籍经 LLM 深度分析，提取摘要、核心概念、主题标签、关键引文和历史意义。装进 agent 后，可以用自然语言查询典籍、追溯概念、对比注疏、检索引文，并在回答中定位出处。

## 能做什么

- **查典籍**：检索任意古籍的摘要、核心概念、主题标签，支持按十大部类过滤
- **概念溯源**：追溯概念在典籍中的出处和演变，对比不同学派差异
- **引文检索**：按部类浏览关键引文，查找特定典籍的代表性原文
- **专题研究**：跨部类综合分析（如"古代养生思想"、"天人关系"），提供学术考证
- **对比分析**：儒道对比、佛道对比、古今对照，同一主题横向比较

## 适合哪些场景

| 场景 | 适合程度 | 说明 |
|------|----------|------|
| 查找某部典籍的内容和背景 | 很适合 | 15,473 部全有摘要、概念、引文 |
| 追溯某个概念的古籍出处 | 很适合 | 200 个核心概念频率排名，附典籍示例 |
| 跨部类专题研究 | 很适合 | 佛藏、道藏、儒藏、史藏等十大部类交叉检索 |
| 学术写作查引文 | 很适合 | 77,952 条引文按部类组织 |
| 学习国学入门 | 很适合 | 9 条学习路径，按部类循序渐进 |
| 查具体某句话出自哪部典籍 | 适合 | full_transcript 有完整索引 |
| 预测未来、算卦 | 不适合 | 本 Skill 提供文献考证，不做确定性预测 |
| 医疗诊断建议 | 不适合 | 医藏内容仅供学术参考，不作为诊疗依据 |

## 部类一览

| 部类 | 数量 | 内容 |
|------|------|------|
| 佛藏 | 5,135 部 | 乾隆藏为主的大藏经 |
| 史藏 | 2,043 部 | 二十四史、方志、政书 |
| 集藏 | 1,727 部 | 历代别集、总集 |
| 道藏 | 1,721 部 | 道教三洞经典 |
| 子藏 | 1,463 部 | 诸子百家著作 |
| 医藏 | 911 部 | 中医典籍 |
| 儒藏 | 908 部 | 十三经及历代注疏 |
| 诗藏 | 776 部 | 诗词总集、诗话 |
| 艺藏 | 446 部 | 书画琴棋艺术典籍 |
| 易藏 | 343 部 | 易经及历代注疏 |

## 安装

### 方式一：让 AI 自己装

把下面这段 prompt 丢给你的 AI 助手：

```
帮我安装 国学大师 skill：
https://github.com/xiyangz543-haha/guoxuedashi.git
```

agent 可以 clone 或使用本地目录，再把 Skill 安装到对应的 skills 目录。

### 方式二：手动安装

```bash
cd guoxuedashi
bash scripts/install.sh --target codex
# 或
bash scripts/install.sh --target claude
# 或
bash scripts/install.sh --target openclaw
```

脚本会把 Skill 装到：

- **Codex**: `~/.codex/skills/guoxuedashi/`
- **Claude Code**: `~/.claude/skills/国学大师/`
- **OpenClaw**: `~/skills/guoxuedashi/`

装完后重启对应 agent，让 skill 元数据重新加载。在 Claude Code 中用 `/国学大师` 激活。

## 使用示例

```
/国学大师 帮我查一下《黄帝内经》的摘要和核心概念
/国学大师 追溯"无为"这个概念在道藏和儒藏中的出处
/国学大师 咳嗽门有哪些关键引文？
/国学大师 儒家和道家对"仁义"的看法有什么不同？
/国学大师 推荐一个佛学入门的研读路径
```

命令行也可以直接检索：

```bash
python3 scripts/search_course_notes.py 黄帝内经
python3 scripts/search_course_notes.py 无为
```

## 目录结构

```
国学大师/
├── SKILL.md                          # Skill 入口和回答规则
├── lineage_manifest.json             # 技能元信息
├── README.md                         # 本文件
├── agents/
│   ├── openai.yaml                   # OpenAI/OpenClaw 接口声明
│   └── openclaw.yaml                 # OpenClaw 隐式调用配置
├── references/
│   ├── course_digest.md              # 课程概览和统计
│   ├── course_package.json           # 结构化课程包（13MB）
│   ├── full_transcript.md            # 完整索引目录（12.8MB）
│   ├── concept_glossary.md           # 概念术语表（200 个）
│   ├── lesson_index.json             # 课程索引
│   ├── quote_index.md                # 引文索引（77,952 条）
│   ├── evidence_map.json             # 证据映射
│   ├── study_paths.md                # 学习路径（9 条）
│   ├── consulting_playbook.md        # 咨询剧本
│   └── scenario_templates.md         # 场景回答模板
└── scripts/
    └── search_course_notes.py        # 本地关键词检索
```

## 回答边界

- 所有回答优先引用 `references/` 中的文件内容，区分典籍原文与模型推断
- 医藏内容仅供学术文献参考，**不做诊疗建议**
- 术数类内容仅作学术研究，**不做确定性预测**
- 当典籍不足以支持回答时，会明确告知缺口

## 技术说明

- **源数据**：[殆知阁古籍库 v2](https://github.com/frankslin/daizhigev20) — 15,694 部古籍
- **蒸馏流水线**：[lineage-skill](https://github.com/JuneYaooo/lineage-skill)
- **LLM 分析**：agnes-2.0-flash / DeepSeek v4 Pro
- **角色**：Consultant（专家顾问型）
- **分析覆盖**：15,473 部成功，0 失败
- **知识库大小**：约 30MB（含全文索引、概念表、引文索引等）
