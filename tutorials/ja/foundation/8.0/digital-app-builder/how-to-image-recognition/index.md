---
layout: tutorial
title: アプリケーションへの画像認識の追加
weight: 10
show_children: true
---
<!-- NLS_CHARSET=UTF-8 -->
## Watson Visual Recognition
{: #dab-watson-vr }

画像認識機能は、IBM Cloud 上の Watson Visual Recognition サービスによって提供されます。 IBM Cloud で Watson Visual Recognition インスタンスを作成します。 詳しくは、[こちら](https://cloud.ibm.com/catalog/services/visual-recognition)を参照してください。

構成後、新規モデルを作成し、クラスをそのモデルに追加できます。 画像をビルダーにドラッグ・アンド・ドロップしてから、該当する画像でモデルをトレーニングできます。 トレーニングの完了後、CoreML モデルをダウンロードすることも、作成したモデルをアプリケーションの AI コントロールで使用することもできます。

アプリケーションで画像認識を有効にするには、以下のステップを実行します。

1. **「Watson」**をクリックし、**「Image Recognition」**をクリックします。 これにより、**「Watson Visual Recognition の操作」**画面が表示されます。

    ![Watson Visual Recognition](dab-watson-vr.png)

2. **「接続」**をクリックして Watson Visual Recognition インスタンスに接続します。

    ![Watson Visual Recognition インスタンス](dab-watson-vr-instance.png)

3. **「API 鍵」**の詳細を入力し、Watson Visual Recognition インスタンスの**「URL」**を指定します。 
4. アプリケーションの Image Recognition インスタンスの**「名前」**を指定し、**「接続」**をクリックします。 これにより、モデルのダッシュボードが表示されます。

    ![Watson VR の新規モデル](dab-watson-vr-new-model.png)

5. **「新規モデルの追加」**をクリックして、新規モデルを作成します。 これにより、**「新規モデルの作成」**ポップアップが表示されます。

    ![Watson VR モデル名](dab-watson-vr-model-name.png)

6. **「モデル名」**を入力し、**「作成」**をクリックします。 これにより、そのモデルのクラスおよび**「ネガティブ」**クラスが表示されます。

    ![Watson VR モデルのクラス](dab-watson-vr-model-class.png)

7. **「新規クラスの追加」**をクリックします。 これにより、新規クラスの名前を指定するためのポップアップが表示されます。

    ![Watson VR モデルのクラス名](dab-watson-vr-model-class-name.png)

8. 新規クラスの**「クラス名」**を入力し、**「作成」**をクリックします。 これにより、モデルをトレーニングするための画像を追加するワークスペースが表示されます。

    ![Watson VR モデルのクラスのトレーニング](dab-watson-vr-model-class-train.png)

9. 画像をワークスペースにドラッグ・アンド・ドロップするか、「参照 (Browse)」を使用して画像にアクセスして、画像をモデルに追加します。

10. 画像を追加した後にワークスペースに戻って、**「モデルのテスト (Test Model)」**をクリックしてテストできます。

    ![Watson VR モデルのクラスのテスト](dab-watson-vr-model-class-train-test.png)

11. **「モデルを試してみてください」**セクションで、画像を追加すると、結果が表示されます。

