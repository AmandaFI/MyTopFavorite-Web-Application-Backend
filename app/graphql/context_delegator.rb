module ContextDelegator
	def delegate_to_context(*keys)
		keys.each do |name|
			define_method name do |*args|
				target_expression = context[name]    # acessa o método do context

				# verifica se são funções, se forem chama passando os argumetos que receber, se não só retorna o valor
				target_expression.is_a?(Proc) ? target_expression.call(*args) : target_expression
			end
		end
	end
end