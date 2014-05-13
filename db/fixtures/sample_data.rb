User.seed(:id,
  { name: "響子", email: "kyoko@example.com", password: "kyokokyoko" }
)

Book.seed(:id,
  { name: "パーフェクトRuby", isbn: "978-4774158792", owner: 1 }
)
