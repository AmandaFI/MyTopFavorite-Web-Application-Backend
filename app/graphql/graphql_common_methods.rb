# Um modulo para evitar ter que chamr dentro dos tyupes e controllers o context[:nome_metodo]
# mas poderia fazer sem criar esse modulo sem problemas
# Lembrar de inclui-lo no arquivo de queries e nas mutations. Nocaso basta incluir em base_object e em 
# base_mutation pois todas as queries e mutations herdam deles respectivamente

# Outra opção é utilizando metaprogramação, ao inves de criar manualmente esses 3 metodos do context,
# cria-se uma função que cria métodos 

module GraphqlCommonMethods

	# Opção com metaprogramação
	extend ContextDelegator
	delegate_to_context :current_user, :logged_in?, :login

	# # Opção escrevendo os métodos manualmente
	# def current_user
	#     context[:current_user]
	# end

	# def logged_in?
	#     context[:lolgged_in?]
	# end

	# def login (user)
	#     context[:login].call(user)
	# end

	def require_authentication!
		raise GraphQL::Error, 'User must be logged in.' unless logged_in?
	end
end