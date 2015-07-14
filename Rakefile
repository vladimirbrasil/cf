# http://www.sitepoint.com/rails-authentication-oauth-2-0-omniauth/

=begin
  Done << Adicionar token 
  Fazer funcionar token_refresh.
  Done << Adicionar email como index em user
  Pode adicionar providers para o mesmo User
    http://code.tutsplus.com/articles/how-to-use-omniauth-to-authenticate-your-users--net-22094
    http://davidlesches.com/blog/clean-oauth-for-rails-an-object-oriented-approach

  Adicionar novo login social:
  1. Adiciona gem (Bundle install)
    gem 'omniauth-linkedin-oauth2'
  2. Adiciona provider (omniauth.rb)
    provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
  3. Cria aplicativo e respectiva callback /auth/linkedin/callback
    linkedin.com/secure/developer | /auth/linkedin/callback | ...
  4. Adiciona novo link (application.html.erb)
    <li><%= link_to 'LinkedIn', '/auth/linkedin' %></li>
  5. Adjust 'from_omniauth' que tenta 'generalizar' (user.rb)
    para não usar if else para cada provider (Criar Ducktype??)
    
=end


# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks
