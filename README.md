![version](https://img.shields.io/badge/version-19%2B-5682DF)
[![license](https://img.shields.io/github/license/miyako/4d-plugin-jwt)](LICENSE)
![downloads](https://img.shields.io/github/downloads/miyako/4d-component-pdfcpu/total)
![deprecated](https://img.shields.io/badge/-deprecated-inactive)

# 4d-component-pdfcpu
4D wrapper for pdfcpu

**Microsoft Print to PDF**は日本語のタイトルが文字化けするみたいなので，タイトルを書き換えるコマンドラインツールの有効性を検証してみました。

[**pdfcpu**](https://pdfcpu.io)はGoで開発されたコマンドラインツールです。

## 概要

```4d
$pdfcpu:=cs.pdfcpu.new()

$PDF:=Folder(fk resources folder).file("test.pdf")

$status:=$pdfcpu.remove_properties($PDF; New collection("Author"; "Title"))

$status:=$pdfcpu.add_properties($PDF; New object("Title"; "あ"; "Author"; "あ"))

$status:=$pdfcpu.list_properties($PDF)
```

* 結果は失敗

<img width="320" alt="スクリーンショット 2022-09-08 8 57 30" src="https://user-images.githubusercontent.com/1725068/189004198-18926a77-0e1b-4b3c-ae68-67a1b82f2384.png">

あ=`0x3042`であり，`0x30`=RS (Record separator) `0x42`=Bなので，UTF-16がそのまま出力されているように見受けられます。

<img width="783" alt="" src="https://user-images.githubusercontent.com/1725068/189006093-bce77dfe-123b-413e-96f3-5ad8f178bf5e.png">
