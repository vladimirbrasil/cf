# gid-omniauth

## links
[Guide to omniauth](http://www.sitepoint.com/rails-authentication-oauth-2-0-omniauth/)

Originals from omniauth: [implementation](https://github.com/intridea/omniauth/wiki/Integration-Testing) | [testing](https://github.com/intridea/omniauth/wiki/Integration-Testing)

Google: [google permissions page](https://myaccount.google.com/intro/security?target=permissions#connectedapps) | [google developer credentials](https://console.developers.google.com/project/gid-project/apiui/credential)

## afazeres
[Configurar botão google signin](https://github.com/zquestz/omniauth-google-oauth2)

Done << Adicionar token

**Fazer funcionar token_refresh**
  
Done << Adicionar email como index em user

Done << Pode adicionar providers para o mesmo User:   [guia 1](http://code.tutsplus.com/articles/how-to-use-omniauth-to-authenticate-your-users--net-22094) | [guia 2](http://davidlesches.com/blog/clean-oauth-for-rails-an-object-oriented-approach)
  
Done << Testing

### refactor
  [A guide for inspiration](http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/)

#### Extract Value Objects

expired? Token expiration equalities...?

#### Extract Service Objects
authenticating with an access token

ex: pull a User#authenticate method out into a UserAuthenticator

posting to social networks | updating contacts in google (external sources)


action reaches multiple models an e-commerce purchase using Order, CreditCard and Customer objects

complex actions closing books after accounting period

#### Extract Form Objects
[in Rails 4 only need to add 'include ActiveModel::Model'](http://crypt.codemancers.com/posts/2013-12-18-form-objects-validations/)

o_auth_user deveria se comportar como ActiveModel::Model?

#### Extract Query Objects
#### Introduce View Objects
#### Extract Policy Objects
#### Extract Decorators
  
## manuais
### Adicionar novo login social
1. Adiciona gem (Bundle install)
    -gem 'omniauth-linkedin-oauth2'
2. Adiciona provider (omniauth.rb)
  
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
 
3. Cria aplicativo e respectiva callback 
    
     /auth/linkedin/callback
      
     linkedin.com/secure/developer
    

1. Adiciona novo link (application.html.erb)

    <li><%= link_to 'LinkedIn', '/auth/linkedin' %></li>

1. Adjust 'from_omniauth' que tenta 'generalizar' (user.rb)
    
    para não usar if else para cada provider (Criar Ducktype??)

### Rodar development
1. Copia variáveis em secrets.txt para o terminal on rodará 'rails s'
2. Roda 'rails s'
3. Em outra janela, roda 'ngrok 3000'
4. Copia links que aparecerão em ngrok 
  
  ex.: https://4186ab55.ngrok.com/
5. Coloca links em [Google developer credentials](https://console.developers.google.com/project/gid-project/apiui/credential)
6. Roda a página no link obtido 

  ex.: https://4186ab55.ngrok.com/
7. Efetua o login. Efetua o logout. Etc.
8. Para obter o refresh token, é necessário que seja refeita a primeira conexão
  * Desfazer a autorização existente (gid) em [Google permissions page](https://myaccount.google.com/intro/security?target=permissions#connectedapps)