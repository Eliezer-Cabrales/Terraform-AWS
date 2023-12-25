# Proyecto Terraform para AWS
Este proyecto utiliza Terraform para definir y desplegar infraestructura en Amazon Web Services (AWS) sencilla, con el fin de mostrar una breve instrucción indicatoria. 
La infraestructura se gestiona como código, lo que permite una implementación consistente y repetible.

## Utilización:

Desde el directorio dónde se encuentren los archivos, usamos:
- ```terraform init```   : Inicializa el backend de Terraform y procede a descargar la configuración necesaria para usar los recursos especificados en los artefactos.
- ```terraform plan```   : Nos permite ver con antelación qué está definiendo nuestros artefactos sin proceder a crearlos.
- ```terraform apply```  : Esto procederá a crear los diferentes recursos especificados abajo.
Para eliminar los componenetes, usamos:
- ```terraform destroy``` : Destruye por completo los elementos creados por estos artefactos de Terraform.

## Componentes Principales:

### Instancia EC2:

Contiene la creación de una instancia Amazon Linux x86 muy sencilla, cuyo propósito es poder conectarse a ella por SSH una vez sea creada.
La instancia es creada directamente en una subred pública. A su vez, está asociada a un grupo de seguridad sencillo que permite tráfico entrante por el puerto 22.

### VPC:

- Crea una VPC.
- Crea dos subredes, de ejemplo, a saber, una pública y otra privada.
- Crea un Internet Gateway que se asocia directamente a la VPC.
- Modifica la tabla de enrutamiento, añadiendo la Internet Gateway a ésta.
- Crea un grupo de seguridad que permite el paso por SSH (Puerto 22 TCP) a cualquier máquina de Internet (0.0.0.0).


