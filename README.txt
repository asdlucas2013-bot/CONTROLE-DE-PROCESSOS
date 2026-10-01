CONTROLE DE PROCESSOS ONLINE

Arquivos:
- index.html = sistema
- config.js = configuração do Supabase
- banco.sql = estrutura do banco e permissões
- README.txt = instruções

ORDEM:
1. Criar um projeto no Supabase.
2. Abrir SQL Editor e executar banco.sql.
3. Criar o usuário administrador em Authentication > Users.
4. Copiar a URL do projeto e a chave pública (anon/publishable).
5. Colocar esses dois dados no config.js.
6. Publicar a pasta em um serviço de hospedagem estática (GitHub Pages, Netlify, Vercel etc.).

SEGURANÇA:
- Nunca publique a SERVICE ROLE KEY.
- A versão inicial permite que usuários autenticados trabalhem com os processos.
- Para separar ADMIN e OPERADOR com permissões diferentes, crieremos a tabela de perfis/roles na próxima etapa.


NOVA FUNÇÃO - CADASTRO DE USUÁRIOS:
- O administrador verá a área "Administração de usuários".
- O administrador pode cadastrar Nome, E-mail, Senha e Perfil (Administrador/Operador).
- O cadastro chama a Edge Function "criar-usuario" do Supabase.
- A Service Role/Secret Key nunca deve ser colocada no navegador.
- O arquivo config.js deve continuar usando somente a chave pública/anon que já funciona no seu sistema.
