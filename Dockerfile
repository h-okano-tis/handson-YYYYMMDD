# ==========================
# Stage 1: Build & Install
# ==========================
FROM node:20-alpine AS builder

# 作業ディレクトリを作成
WORKDIR /app

# 依存関係定義ファイルのみコピー（キャッシュ効率化）
COPY package*.json ./

# 依存関係をインストール（開発依存は除外）
RUN npm ci --omit=dev

# アプリケーションソースをコピー
COPY . .

# ==========================
# Stage 2: Runtime
# ==========================
FROM node:20-alpine

# 作業ディレクトリ
WORKDIR /app

# builderからnode_modulesをコピー（再インストール不要）
COPY --from=builder /app/node_modules ./node_modules

# ソースコードをコピー
COPY --from=builder /app ./

# 環境変数
ENV NODE_ENV=production
ENV PORT=3000

# ポート公開
EXPOSE 3000

# アプリ起動コマンド
CMD ["node", "index.js"]