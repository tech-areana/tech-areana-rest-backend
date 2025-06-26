-- クイズユーザーが存在しなければ作成
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT FROM pg_catalog.pg_roles WHERE rolname = 'quizuser'
  ) THEN
    CREATE ROLE quizuser LOGIN PASSWORD 'quizpass';
  END IF;
END
$$;

-- クイズユーザーにDBとスキーマの権限を付与
GRANT ALL PRIVILEGES ON DATABASE quiz TO quizuser;
GRANT USAGE, CREATE ON SCHEMA public TO quizuser;  -- ★ これを追加！


-- === TABLES ==============================================================
DROP TABLE IF EXISTS trx_user;
DROP TABLE IF EXISTS quizzes;

CREATE TABLE trx_user (
  u_id TEXT PRIMARY KEY,
  email TEXT NOT NULL,
  user_name TEXT NOT NULL,
  icon_path TEXT DEFAULT 'default.png',
  role TEXT CHECK (role IN ('user', 'admin')) DEFAULT 'user',
  hard_clear_num INTEGER DEFAULT 0,
  normal_clear_num INTEGER DEFAULT 0,
  easy_clear_num INTEGER DEFAULT 0,
  hard_correct_num INTEGER DEFAULT 0,
  normal_correct_num INTEGER DEFAULT 0,
  easy_correct_num INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

CREATE TABLE quizzes (
  id SERIAL PRIMARY KEY,
  level TEXT CHECK (level IN ('hard', 'normal', 'easy')) NOT NULL,
  level_id INTEGER NOT NULL,
  quiz TEXT NOT NULL,
  option1 TEXT,
  option2 TEXT,
  option3 TEXT,
  option4 TEXT,
  answer CHAR(1) NOT NULL,
  explanation TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP
);

-- === SEED : USERS =========================================================
INSERT INTO trx_user (u_id, email, user_name) VALUES
  ('user001', 'alice@example.com', 'Alice'),
  ('user002', 'bob@example.com', 'Bob');

-- === SEED : QUIZZES  (EASY) ==============================================
INSERT INTO quizzes (
  level, level_id, quiz,
  option1, option2, option3, option4,
  answer, explanation
) VALUES
  ('easy', 1,  'Pythonでリストの要素数を取得する方法は？',
   'len()', 'count()', 'size()', 'length()',
   'A', 'len() 関数でリストの要素数を取得します。'),

  ('easy', 2,  'Pythonで辞書のキー一覧を取得するには？',
   'dict.keys()', 'dict.values()', 'dict.items()', 'dict.all()',
   'A', 'keys() メソッドでキー一覧が取得できます。'),

  ('easy', 3,  'Pythonのリストに要素を追加するには？',
   'append()', 'add()', 'push()', 'insert()',
   'A', 'append() メソッドで末尾に追加します。'),

  ('easy', 4,  'Pythonで整数を文字列に変換する関数は？',
   'str()', 'int()', 'char()', 'convert()',
   'A', 'str() で整数を文字列に変換できます。'),

  ('easy', 5,  'Pythonで変数の型を調べる関数は？',
   'type()', 'kind()', 'format()', 'id()',
   'A', 'type() で型がわかります。'),

  ('easy', 6,  'Pythonで文字列を整数に変換する関数は？',
   'int()', 'str()', 'float()', 'chr()',
   'A', 'int() で整数に変換します。'),

  ('easy', 7,  'Pythonでインデントに使うべきは？',
   'タブ', '半角スペース', '全角スペース', '両方可',
   'B', 'PEP8では半角スペースを推奨しています。'),

  ('easy', 8,  'Pythonでコメントを書く方法は？',
   '//', '#', '--', '/* */',
   'B', '# を使ってコメントを記述します。'),

  ('easy', 9,  'Pythonで論理ANDを表すキーワードは？',
   'and', '&&', '&', 'AND',
   'A', 'and が正しい論理ANDです。'),

  ('easy', 10, 'PythonでNoneを判定するには？',
   'value = NULL', 'value IS NULL', 'is None', '== None',
   'C', 'is None が正しい書き方です。'),

  ('easy', 11, 'Pythonでリストの末尾の要素を取り除くメソッドは？',
   'remove()', 'pop()', 'delete()', 'cut()',
   'B', 'pop() で末尾の要素を取り除きます。'),

  ('easy', 12, 'Pythonで文字列をすべて大文字に変換するには？',
   'upper()', 'capitalize()', 'toupper()', 'uppercase()',
   'A', 'upper() で全て大文字に変換できます。'),

  ('easy', 13, 'Pythonで1から10までの範囲を生成するには？',
   'range(1,10)', 'range(1,11)', 'range(10)', 'range(0,10)',
   'B', 'range(1,11) は1〜10を生成します。'),

  ('easy', 14, 'Pythonで要素の数をカウントするリストメソッドは？',
   'length()', 'count()', 'size()', 'number()',
   'B', 'count() で特定要素の出現数をカウントします。'),

  ('easy', 15, 'Pythonのリストを昇順に並べ替えるには？',
   'sort()', 'order()', 'arrange()', 'ascend()',
   'A', 'sort() で昇順に並べ替えられます。'),

  ('easy', 16, 'Pythonで1行コメントを書くには？',
   '#', '//', '--', '/* */',
   'A', '# を使います。'),
  ('easy', 17, 'Pythonで「等しいかどうか」の比較演算子は？',
   '==', '=', '===', '!=',
   'A', '== は比較演算子です。'),
  ('easy', 18, 'Pythonで繰り返し処理に使うキーワードは？',
   'loop', 'iterate', 'for', 'repeat',
   'C', 'for ループが使われます。'),
  ('easy', 19, 'Pythonで条件分岐に使うキーワードは？',
   'case', 'if', 'switch', 'when',
   'B', 'if 文を使います。'),
  ('easy', 20, 'Pythonで1つの文字を取得するには？',
   'index()', 'charAt()', '[]', 'substring()',
   'C', '文字列[index] で取得できます。'),
  ('easy', 21, 'Pythonで改行文字は？',
   '\\n', '\\t', '\\r', '\\b',
   'A', '\\n は改行文字です。'),
  ('easy', 22, 'Pythonで変数に整数を代入する方法は？',
   'int x = 5', 'x = 5', 'let x = 5', 'define x 5',
   'B', 'x = 5 のように代入します。'),
  ('easy', 23, 'Pythonで文字列を連結するには？',
   '+', '-', '*', '/',
   'A', '+ で連結できます。'),
  ('easy', 24, 'Pythonで空のリストを作成するには？',
   '[]', '{}', '()', 'empty()',
   'A', '[] は空のリストです。'),
  ('easy', 25, 'Pythonで文字列の長さを取得するには？',
   'size()', 'length()', 'len()', 'count()',
   'C', 'len() を使います。'),
  ('easy', 26, 'PythonでTrueとFalseは？',
   '整数', '文字列', 'ブール型', 'リスト',
   'C', 'Pythonの真偽値はブール型です。'),
  ('easy', 27, 'Pythonのインデントは通常何スペース？',
   '2', '3', '4', '8',
   'C', 'PEP8では4スペースが推奨されます。'),
  ('easy', 28, 'Pythonで型を文字列として取得するには？',
   'typeof()', 'gettype()', 'strtype()', 'type()', 
   'D', '`type()` で型オブジェクトが得られます。'),
  ('easy', 29, 'Pythonで要素がリストにあるかを調べるには？',
   'in', 'has()', 'find()', 'locate()', 
   'A', '`in` を使って調べられます。'),
  ('easy', 30, 'Pythonで関数を定義するキーワードは？',
   'define', 'func', 'function', 'def',
   'D', 'def を使います。'),

  ('normal', 1, 'Pythonでリストを逆順に並び替えるメソッドは？',
   'reverse()', 'reversed()', 'sort(reverse=True)', '反転()',
   'A', 'reverse() でその場で逆順に並び替えます。'),

  ('normal', 2, 'Pythonで関数の引数にデフォルト値を指定する正しい方法は？',
   'def func(x=1):', 'def func(x):=1', 'func def(x=1):', 'def(x=1) func:',
   'A', 'def func(x=1): の形式で指定します。'),

  ('normal', 3, 'Pythonでリスト内包表記の書き方は？',
   '[x for x in list]', 'for x in list -> x', '{x in list}', 'list(x)',
   'A', '[x for x in list] の形式です。'),

  ('normal', 4, 'Pythonの例外処理に使うキーワードは？',
   'try-except', 'try-catch', 'throw-catch', 'try-handle',
   'A', 'Pythonでは try-except を使用します。'),

  ('normal', 5, 'Pythonの標準入力を取得する関数は？',
   'input()', 'scan()', 'read()', 'gets()',
   'A', 'input() で標準入力を取得します。'),

  ('normal', 6, 'Pythonでクラスを定義するキーワードは？',
   'class', 'define', 'struct', 'type',
   'A', 'class を使ってクラスを定義します。'),

  ('normal', 7, 'Pythonでファイルを読み込むには？',
   'open(''file.txt'')', 'read(''file.txt'')', 'get(''file.txt'')', 'load(''file.txt'')',
   'A', 'open() でファイルを開きます。'),

  ('normal', 8, 'Pythonで複数行の文字列を扱う方法は？',
    '"""text"""', '`text`', '//text//', 'text()',
    'A', '""" か '''' で複数行文字列を定義できます。'),

  ('normal', 9, 'Pythonで辞書の全要素をループする方法は？',
   'for k, v in dict.items()', 'for each in dict', 'loop dict', 'dict.loop()',
   'A', 'items() でキーと値を取得できます。'),

  ('normal', 10, 'PythonでNoneとの比較で推奨される方法は？',
   'is None', '== None', '= None', 'equals None',
   'A', 'is None が推奨されます。'),

  ('normal', 11, 'Pythonで文字列の先頭や末尾の空白を削除するメソッドは？',
   'strip()', 'trim()', 'remove()', 'clean()',
   'A', 'strip() で前後の空白を削除します。'),

  ('normal', 12, 'Pythonのタプルはどのような特徴を持つ？',
   '可変である', '順序がない', '変更不可である', '辞書のキーに使えない',
   'C', 'タプルはイミュータブル（変更不可）です。'),

  ('normal', 13, 'Pythonでリストをコピーする正しい方法は？',
   'copy()', 'list()', '[:] でスライス', 'すべて正しい',
   'D', 'どれも有効なコピー方法です。'),

  ('normal', 14, 'Pythonで例外の種類を指定するには？',
   'except IOError:', 'except = IOError:', 'catch IOError:', 'try IOError:',
   'A', 'except IOError: のように書きます。'),

  ('normal', 15, 'Pythonで辞書の値だけ取得するメソッドは？',
   'values()', 'keys()', 'items()', 'get()',
   'A', 'values() で値だけ取得できます。'),

  ('normal', 16, 'Pythonのスライス記法 [1:4] の意味は？',
   '1から4まで', '0から4まで', '1から3まで', '2から5まで',
   'C', '終了インデックスは含まれないため 1〜3 までを意味します。'),

  ('normal', 17, 'Pythonで例外を無視するには？',
   'try: except: pass', 'ignore: error', 'skip error', 'raise ignore',
   'A', 'pass を使って何もしないようにします。'),

  ('normal', 18, 'Pythonのenumerate()関数は何を返す？',
   'キーと値', 'インデックスと要素', '文字列とリスト', 'リストと辞書',
   'B', 'インデックスと要素のタプルを返します。'),

  ('normal', 19, 'Pythonで複数の例外をまとめて処理するには？',
   'except (A, B):', 'except A + B:', 'try A, B:', 'handle A, B:',
   'A', 'except (A, B): で複数指定できます。'),

  ('normal', 20, 'Pythonでリストから要素を削除する方法は？',
   'remove()', 'delete()', 'discard()', 'popitem()',
   'A', 'remove() は指定した要素を削除します。'),

  ('normal', 21, 'Pythonで文字列を数値に変換するには？',
   'int()', 'str()', 'ord()', 'convert()',
   'A', 'int() を使って文字列を整数に変換します。'),

  ('normal', 22, 'Pythonの関数内で変数をグローバルに扱うには？',
   'global', 'extern', 'public', 'static',
   'A', 'global を使います。'),

  ('normal', 23, 'Pythonで辞書のキーが存在するか確認するには？',
   '"key" in dict', 'dict.hasKey("key")', 'dict.contains("key")', 'dict.keyExists("key")',
   'A', 'in を使って確認します。'),

  ('normal', 24, 'Pythonでデフォルト辞書に使うのは？',
   'defaultdict', 'dictset', 'autodict', 'lazydict',
   'A', 'collections.defaultdict を使います。'),

  ('normal', 25, 'Pythonでラムダ関数を使う理由は？',
   '簡潔に書ける', '高速化のため', 'エラーを回避するため', 'メモリ削減のため',
   'A', '短い関数を簡潔に記述できます。'),

  ('normal', 26, 'Pythonで複数のリストを同時にループ処理する関数は？',
   'zip()', 'join()', 'map()', 'reduce()',
   'A', 'zip() を使って並行処理できます。'),

  ('normal', 27, 'Pythonのassert文は何のために使う？',
   '例外処理', 'ログ出力', 'デバッグ用のチェック', '変数定義',
   'C', 'assert はテストやデバッグ時の検証に使います。'),

  ('normal', 28, 'Pythonの関数に渡す引数をキーワードで指定するとは？',
   '順番無視で名前指定', 'デフォルト値の略記', 'キーワード一覧を渡す', '環境変数を渡す',
   'A', 'func(x=3, y=4) のように名前指定で渡します。'),

  ('normal', 29, 'Pythonでモジュールを読み込む方法は？',
   'import モジュール名', 'include モジュール名', 'load モジュール名', 'use モジュール名',
   'A', 'import を使います。'),

  ('normal', 30, 'Pythonのrange(3,10,2)の意味は？',
   '3〜10を2つずつスキップ', '10から3まで2ずつ減少', '3〜9を2ずつ増加', '2〜10まで3ずつ',
   'C', '3, 5, 7, 9 のように増加します。'),

  ('hard', 1, 'Pythonでデコレータとは何か？',
   '関数をラップする関数', '関数をコピーする構文', '関数を削除する命令', '関数を変数化する方法',
   'A', 'デコレータは関数をラップして機能を追加します。'),

  ('hard', 2, 'Pythonのジェネレータ式の利点は？',
   'メモリ効率が良い', '計算が速い', 'コードが短い', '複数スレッドで動く',
   'A', 'ジェネレータは遅延評価でメモリ効率が良いです。'),

  ('hard', 3, 'Pythonでwith文の利点は？',
   '自動的にcloseされる', '同期処理になる', 'デバッグしやすい', 'メモリが倍速になる',
   'A', 'with によってリソースの開放が保証されます。'),

  ('hard', 4, 'Pythonでラムダ関数の正しい定義方法は？',
   'lambda x: x + 1', 'x -> x + 1', 'function(x) = x + 1', 'def x(x): return x+1',
   'A', 'lambda x: x + 1 の形式で定義します。'),

  ('hard', 5, 'Pythonでスレッドを扱うには？',
   'threading モジュール', 'multiprocessing モジュール', 'thread モジュール', 'parallel モジュール',
   'A', 'スレッドは threading モジュールで扱います。'),

  ('hard', 6, 'Pythonで型ヒントを使う理由は？',
   'コードの可読性向上', '実行速度向上', 'メモリ使用減', '例外処理強化',
   'A', '型ヒントでIDEや補完が使いやすくなります。'),

  ('hard', 7, 'Pythonで例外を再送出する方法は？',
   'raise', 'throw', 'error', 'except',
   'A', 'raise を使って再送出します。'),

  ('hard', 8, 'Pythonで再帰関数が必要な場合は？',
   '自己参照処理', '高速化', '型チェック', 'ファイル操作',
   'A', '再帰関数は分割・構造的な処理に適します。'),

  ('hard', 9, 'Pythonでグローバル変数を関数内で使うには？',
   'global宣言する', 'constで囲う', 'defで囲う', 'varで囲う',
   'A', 'global 宣言で明示的に使えます。'),

  ('hard', 10, 'Pythonでソートをカスタマイズするには？',
   'key引数を使う', 'sortmodeを使う', 'setmodeを使う', 'compareを使う',
   'A', 'key=関数 でカスタムソートができます。'),

  ('hard', 11, 'Pythonで複数の例外型を1つのexceptで処理するには？',
   'except A or B:', 'except (A, B):', 'except A, B:', 'except A and B:',
   'B', 'タプルで複数の例外型を指定できます。'),

  ('hard', 12, 'Pythonでリストの重複を除去する方法は？',
   'unique()', 'filter()', 'set()', 'distinct()',
   'C', 'set() で一時的に重複が除去されます。'),

  ('hard', 13, 'Pythonでジェネレータ関数を定義するには？',
   'function*', 'gen def', 'def + yield', 'def generator()',
   'C', 'yield を含む関数がジェネレータです。'),

  ('hard', 14, 'Pythonのデコレータに関数を渡すには？',
   '@デコレータ名', '#デコレータ名', '$デコレータ名', 'decorator()',
   'A', '@デコレータ名 を関数の上に書きます。'),

  ('hard', 15, 'Pythonの__init__.pyの役割は？',
   'クラスを定義する', 'パッケージ化', '依存解決', 'テスト用設定',
   'B', 'ディレクトリをパッケージとして認識させます。'),
  ('hard', 16, 'Pythonで引数の数が可変の関数を定義するには？', '*args を使う', '**kwargs を使う', '引数を省略する', 'default引数を使う', 'A', '*args によって複数引数をタプルで受け取れます。'),
  ('hard', 17, 'Pythonの@staticmethodの特徴は？', 'selfを受け取る', 'インスタンスメソッド', 'クラスを受け取る', 'インスタンスなしで呼べる', 'D', 'インスタンス不要で呼び出せます。'),
  ('hard', 18, 'Pythonでwith open(...)が便利なのはなぜ？', '自動でcloseされる', '高速化される', '並列処理になる', '暗号化される', 'A', 'ファイルクローズを自動で行ってくれます。'),
  ('hard', 19, 'Pythonのガベージコレクション機構で使われるのは？', '参照カウント', 'マーク＆スイープ', '世代別GC', '全て', 'D', 'CPythonは参照カウントと世代別GCを併用しています。'),
  ('hard', 20, 'Pythonのクロージャとは？', '関数内で定義された関数', '他関数を呼ぶ関数', 'クラスの一部', '装飾用関数', 'A', '外部スコープの変数を保持した関数です。'),
  ('hard', 21, 'Pythonの__name__ == "__main__"の意味は？', '外部から呼ばれたときに実行', 'インポートされたとき実行', '直接実行時のみ実行', '何もしない', 'C', '直接ファイルを実行したときにだけ処理されます。'),
  ('hard', 22, 'Pythonで文字列のフォーマット方法はどれ？', 'str.format()', 'string.replace()', 'str.concat()', 'format.str()', 'A', 'str.format() で挿入できます。'),
  ('hard', 23, 'Pythonのmap()関数の特徴は？', 'リストを結合する', '条件を満たす要素を抽出', '要素に関数を適用', '並列処理をする', 'C', '関数をすべての要素に適用します。'),
  ('hard', 24, 'Pythonで高階関数とは？', '戻り値がタプルの関数', '引数に関数を取る関数', '処理速度が高い関数', '並列処理関数', 'B', '関数を引数や戻り値にできる関数です。'),
  ('hard', 25, 'Pythonでモジュールを再読み込みするには？', 'importlib.reload()', 'reload()', 'refresh()', 'reimport()', 'A', 'importlib.reload() を使用します。'),
  ('hard', 26, 'Pythonでクラスメソッドを定義するには？', '@classmethod', '@staticmethod', '@instancemethod', '@init', 'A', '@classmethod を使います。'),
  ('hard', 27, 'Pythonで再帰の最大回数を設定するには？', 'sys.setrecursionlimit()', 'os.setlimit()', 'limit.recursion()', 'threading.setdepth()', 'A', 'sys モジュールを使います。'),
  ('hard', 28, 'Pythonのモジュール検索順序で先に見られるのは？', '現在のディレクトリ', '標準ライブラリ', 'インストール済パッケージ', 'Cドライブ', 'A', '現在のスクリプトディレクトリが最初に検索されます。'),
  ('hard', 29, 'Pythonで変数の型注釈をサポートする機能は？', '型ヒント', '型推論', '型検証', '型強制', 'A', '型ヒントは補完や解析に役立ちます。'),
  ('hard', 30, 'Pythonで並列処理を行う標準モジュールは？', 'threading', 'multiprocessing', 'concurrent.futures', '全て', 'D', 'どれも並列処理に使えます。');



-- quizzes テーブル定義ここまで

-- ✅ ここで権限付与（GRANT）を移動
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO quizuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO quizuser;

-- 所有者をquizuserに変更（これがないとGRANTだけでは不十分）
ALTER TABLE trx_user OWNER TO quizuser;
ALTER TABLE quizzes OWNER TO quizuser;
