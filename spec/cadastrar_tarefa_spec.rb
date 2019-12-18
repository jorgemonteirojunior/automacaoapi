describe 'Cadastrar' do
    def login(field_email, field_password)
        @body = {
            session: {
                email: field_email,
                password: field_password
            }
        }.to_json
        @login = Login.post('/sessions', body: @body)
        puts @login.body
    end
    context 'tarefas' do
        before { login('edimilsonestevam@owltechnologies.com.br', '123456') }

        it 'com sucesso' do
            @header = {
                'Content-Type': 'application/json',
                Accept: 'application/vnd.tasksmanagers.v2',
                Authorization: @login.parsed_response['data']['attributes']['auth-token']
            }

            @body = {
                task: {
                    title: 'Criei Tarefa',
                    description: 'Descrição de tarefa criei tarefa.',
                    deadline: '2018-08-21 15:00:00',
                    done: true
                }
            }.to_json

            @tarefas = Cadastrar.post('/tasks', body: @body, headers: @header)
            puts @tarefas
            expect(@tarefas.parsed_response['data']['attributes']['title']).to eq 'Criei Tarefa'
        end
    end
end
