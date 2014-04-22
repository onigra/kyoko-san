Fabricator :perfect_ruby, class_name: Book do
  name 'パーフェクトRuby'
  isbn '978-4774158792'
  owner { Fabricate(:sample_user).id }
end
