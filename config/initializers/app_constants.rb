# Cantidad de líneas por página
APP_LINES_PER_PAGE = 16
# Subdominio donde ingresan los operarios/encargados
USER_SUBDOMAIN = 'prints'
# IP interna del servidor donde ingresan operarios/encargados
LOCAL_SERVER_IP = '192.168.0.9'
# Subdominio donde ingresan los clientes
CUSTOMER_SUBDOMAIN = 'fotocopia'
# Umbral crédito / precio para determinar si se imprime o no un pedido
CREDIT_THRESHOLD = 0.7
# Adaptador de base de datos
DB_ADAPTER = ActiveRecord::Base.connection.adapter_name
# Idiomas disponibles
LANGUAGES = [:es]
# Dominio público
PUBLIC_DOMAIN = APP_CONFIG['public_host'].split(':').first
# Puerto público
PUBLIC_PORT = APP_CONFIG['public_host'].split(':')[1]
# Protocolo público
PUBLIC_PROTOCOL = 'http'
# Directorio temporal para imágenes de códigos de barra
TMP_BARCODE_IMAGES = File.join(Rails.root, 'tmp', 'codes')
# Validez de los tokens para cambiar contraseña y activar cuenta
TOKEN_VALIDITY = 1.day
