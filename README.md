# ansible-esxi-kickstart

kickstartを埋め込んだESXiのカスタムイメージを作成するansibleのsample


## 使い方
1. `playbook.yml`内のvarsを変更する。全ての変数が必須。不要な場合は適宜`playbook.yml`や`KS.CFG.j2`を書き換えること

|変数名               |概要                                     |example                                            |
|------------------|---------------------------------------|---------------------------------------------------|
|rootpw.password   | ESXiのrootパスワード                        | Passw@rd                                          |
|rootpw.crypted    | hash化したpasswordを指定したい場合はtrue          | true                                              |
|network.device    | ESXiの管理用に使用するvmnic                    | vmnic0                                            |
|network.ip        | ESXiのIP                               | 10.0.10.11                                        |
|network.netmask   | サブネットマスク                              | 255.255.254.0                                     |
|network.gateway   | デフォルトゲートウェイ                           | 10.0.10.1                                         |
|network.hostname  | ESXiのFQDN                             | v10-nesxi-01.lab.local                            |
|network.vlanid    | ESXiのvLANID(0の場合vlan無し)               | 0                                                 |
|network.nameserver| ESXiのFQDNの名前解決ができるserver(複数指定はカンマ区切り) | 10.0.10.1, "10.0.10.1,10.0.10.2"                                         |
|path.esxi_image   | 元となるESXiのインストールイメージ                   | VMware-VMvisor-Installer-8.0U1-21495797.x86_64.iso|
|path.tmp_dir      | ESXiのインストールイメージを一時的に展開する作業用ディレクトリ     | /tmp/extract                                      |
|path.output_image | 作成したカスタムイメージの出力先                      | custom_esxi.iso                                   |
|efi               | カスタムイメージをEFIブートする場合にtrue(biosと両方true可)| true                                              |
|bios              | カスタムイメージをBIOSブートする場合にtrue(efiと両方true可)| true                                              |

2. ESXiのインストールイメージ(iso)を用意して、`path.esxi_image`の場所に配置しておく

例: 
```
ansible-esxi-kickstart/
├── Dockerfile
├── KS.CFG.j2
├── LICENSE
├── playbook.yml
├── README.md
└── VMware-VMvisor-Installer-8.0U1-21495797.x86_64.iso
```

3. ansibleを実行できる環境用意して、実行。

別途genisoimageと7zのinstallが必要。install方法は`Dockerfile`参考

```
ansible-playbook playbook.yml
```

dockerで実施したい場合は以下
```
docker build -t ansible-esxi-kickstart .
docker run --rm -it -v $(pwd):/app -w /app ansible-esxi-kic
kstart ansible-playbook playbook.yml
```

4. 完成したカスタムイメージを確認する。