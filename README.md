# terraform-azure-examples
Exemplos de configurações do [Terraform][tf] com a [Azure][az], do básico ao complexo ...


# Exemplos disponíveis

Cada diretório é um exemplo, veja os detalhes na tabela abaixo:

| Exemplo                       | Descrição  |
|-------------------------------|--------------------------------------------------------------------------|
| exemplo01-azure-vm            | Cria o resource group, network security group, nic, public ip e a VM     |
| exemplo02-privisioners        | Igual ao anterior. Mas copia um arquivo e executa um shell               |
| exemplo03-modules             | Cria os recursos utilizando os módulos network e compute                 |

# Configurando as credenciais na amazon

No meu site descrevo como criar as credenciais, veja no link [Cloud: Primeiros passos na CLI da Microsoft Azure](http://ebasso.net/wiki/index.php?title=Cloud:_Primeiros_passos_na_CLI_da_Microsoft_Azure)




# Como executar os exemplos?

Escolha um do diretórios de exemplo e e execute os comandos:


## Cloning terraform-azure-examples from git

```
cd
git clone https://github.com/ebasso/terraform-azure-examples.git
```

## Inicializando o ambiente

```
cd terraform-aws-examples/exemplo01-aws-t2-micro

terraform init
```

## Criando as instâncias/objetos na AWS

```
terraform apply
```

## Deletando as instâncias/objetos na AWS

```
terraform destroy
```



# Authors

* **Enio Basso** - *Initial work* - [My Repository](https://github.com/ebasso)


# License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

# End Of file. :)

[tf]: http://terraform.io
[az]: https://azure.microsoft.com