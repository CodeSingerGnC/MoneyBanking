#!/usr/bin/env bash
#
# fetch_lectures.sh — 下载/更新 Perry Mehrling《Money & Banking》22 讲 PDF 讲义。
#
# 数据源：https://sites.bu.edu/perry/lectures/mb-lectures/（官方讲义页）
# 用法：  bash scripts/fetch_lectures.sh
#
# 脚本幂等：已存在且非空的 PDF 会跳过，重新运行只补缺。
# 输出目录：lectures/pdf/

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
OUT_DIR="$REPO_ROOT/lectures/pdf"
BASE_URL="https://sites.bu.edu"

mkdir -p "$OUT_DIR"

# 每行：讲次编号 | 标题 | 官方站点上的 PDF 相对路径
LECTURES=(
  "01|The Four Prices of Money|/perry/files/2019/01/Lec-01-The-Four-Prices-of-Money.pdf"
  "02|The Natural Hierarchy of Money|/perry/files/2019/01/Lec-02-The-Natural-Hierarchy-of-Money.pdf"
  "03|Money and the State: Domestic|/perry/files/2019/01/Lec-03-Money-and-the-State-Domestic.pdf"
  "04|The Money View, Micro and Macro|/perry/files/2019/01/Lec-04-The-Money-View-Micro-and-Macro.pdf"
  "05|The Central Bank as a Clearinghouse|/perry/files/2019/01/Lec-05-The-Central-Bank-as-a-Clearinghouse.pdf"
  "06|Federal Funds, Final Settlement|/perry/files/2019/01/Lec-06-Federal-Funds-Final-Settlement.pdf"
  "07|Repos, Postponing Settlement|/perry/files/2019/01/Lec-07-Repos-Postponing-Settlement.pdf"
  "08|Eurodollars, Parallel Settlement|/perry/files/2019/01/Lec-08-Eurodollars-Parallel-Settlement.pdf"
  "09|The World that Bagehot Knew|/perry/files/2019/01/Lec-09-The-World-that-Bagehot-Knew.pdf"
  "10|Dealers and Liquid Security Markets|/perry/files/2019/01/Lec-10-Dealers-and-Liquid-Security-Markets.pdf"
  "11|Banks and the Market for Liquidity|/perry/files/2019/01/Lec-11-Banks-and-The-Market-for-Liquidity.pdf"
  "12|Lender/Dealer of Last Resort|/perry/files/2019/01/Lec-12-Lender-or-Dealer-of-Last-Resort.pdf"
  "13|Chartallism, Metallism, and Key Currencies|/perry/files/2019/01/Lec-13-Chartalism-Metallism-and-Key-Currencies.pdf"
  "14|Money and the State: International|/perry/files/2019/01/Lec-14-Money-and-the-State-International.pdf"
  "15|Banks and Global Liquidity|/perry/files/2019/01/Lec-15-Banks-and-Global-Liquidity.pdf"
  "16|Foreign Exchange|/perry/files/2019/01/Lec-16-Foreign-Exchange.pdf"
  "17|Direct and Indirect Finance|/perry/files/2019/01/Lec-17-Direct-and-Indirect-Finance.pdf"
  "18|Forwards and Futures|/perry/files/2019/01/Lec-18-Forwards-and-Futures.pdf"
  "19|Interest Rate Swaps|/perry/files/2019/01/Lec-19-Interest-Rate-Swaps.pdf"
  "20|Credit Default Swaps|/perry/files/2019/01/Lec-20-Credit-Derivatives.pdf"
  "21|Shadow Banking, Central Banking, and Global Finance|/perry/files/2019/01/Lec-21-Shadow-Banking-Central-Banking.pdf"
  "22|Touching the Elephant: Three Views|/perry/files/2019/01/Lec-22-Touching-the-Elephant-three-views.pdf"
)

OK=0
FAIL=0

for entry in "${LECTURES[@]}"; do
  num="${entry%%|*}"
  rest="${entry#*|}"
  title="${rest%%|*}"
  path="${rest#*|}"
  filename="$(basename "$path")"
  out="$OUT_DIR/$filename"

  if [ -s "$out" ]; then
    echo "skip  $num: $filename（已存在）"
    OK=$((OK + 1))
    continue
  fi

  url="$BASE_URL$path"
  if curl -fL --retry 3 --retry-delay 2 -o "$out.tmp" "$url" && [ -s "$out.tmp" ]; then
    mv "$out.tmp" "$out"
    echo "ok    $num: $filename"
    OK=$((OK + 1))
  else
    rm -f "$out.tmp"
    echo "FAIL  $num: $title  <- $url" >&2
    FAIL=$((FAIL + 1))
  fi
done

echo
echo "完成：成功/已存在 $OK 份，失败 $FAIL 份（共 ${#LECTURES[@]} 份）。"
exit $FAIL
