# Configuración de Chatwoot

Guía rápida para conectar Facebook Messenger e Instagram a Chatwoot. Instagram usa aquí la conexión **legacy mediante Facebook Login**; no la integración independiente de Instagram.

## Antes de empezar

Necesitás acceso a **Super Admin de Chatwoot**, a la **Meta App** y a la **página de Facebook**. Para Instagram, la cuenta debe ser profesional y estar vinculada a esa página.

En los ejemplos, reemplazá `TU-DOMINIO-CHATWOOT` por el dominio de tu instalación. Nuestro DEV es `chatwoot-dev-4c64.up.railway.app`.

## 1. Qué es cada dato

| Dato | Para qué sirve / de dónde sale |
|---|---|
| **App ID** | Identifica la aplicación. Meta Developers → tu app → Configuración de la app → Básica. |
| **App Secret** | Credencial secreta de la aplicación. En la misma pantalla → Clave secreta → Mostrar. |
| **Verify Token** | Cadena aleatoria segura que creamos nosotros. Se copia igual en Chatwoot y Meta para verificar el webhook. Usamos una para Facebook y otra para Instagram. |
| **Page Access Token** | Autoriza el acceso a una página. Chatwoot lo obtiene al conectar la página con Facebook. El botón «Generar token» de Meta también permite obtener uno manualmente; no reemplaza los campos anteriores. |
| **Webhook** | URL a la que Meta envía mensajes y otros eventos. Facebook e Instagram tienen URLs diferentes. |

No publiques App Secrets ni tokens en documentos, repositorios o capturas.

## 2. Facebook Messenger

### A. Configurar Chatwoot

En **Super Admin → Channels → Messenger**, completar:

| Campo | Valor |
|---|---|
| **Facebook App ID** | App ID de Meta. |
| **Facebook App Secret** | App Secret de la misma aplicación. |
| **Facebook Verify Token** | Una cadena aleatoria segura; guardarla para el paso B. |
| **Instagram Verify Token** | Se completa en la sección 3 si también conectás Instagram. |
| **Facebook API Version** | Usar una versión vigente y compatible con la instalación; no copiar una versión antigua de una captura. |
| **Enable human agent** | `False` para la prueba inicial. |

Pulsar **Save changes**.

### B. Configurar Meta

En **Meta Developers → tu app → Caso de uso Messenger → Configuración de la API de Messenger → Configurar webhooks**:

- **URL de devolución de llamada:** `https://TU-DOMINIO-CHATWOOT/bot`
- **Token de verificación:** el mismo **Facebook Verify Token** de Chatwoot.

Pulsar **Verificar y guardar**.

En **Generar tokens de acceso**, agregar la página. En sus suscripciones, seleccionar los eventos que solicita Chatwoot:

`messages`, `message_deliveries`, `message_reads`, `message_echoes`, `messaging_postbacks`, `messaging_handovers` y `standby`.

`messages` recibe mensajes; los demás notifican entregas, lecturas, mensajes enviados, botones y cambios de control de la conversación.

### C. Conectar la bandeja

En **Chatwoot → Configuración → Bandejas de entrada → Añadir bandeja → Messenger/Facebook**, iniciar sesión con Facebook, autorizar los permisos y seleccionar la página.

En **Meta Business Suite → Configuración → Integraciones → Enrutamiento de conversaciones**, seleccionar la página y comprobar que **Anura Connect** sea la aplicación predeterminada.

## 3. Instagram mediante Facebook Login

Comparte las credenciales de Facebook y puede usar la misma bandeja de Chatwoot, pero **recibe los eventos por otro webhook**.

1. En la página de Facebook → **Configuración → Cuentas vinculadas**, comprobar que esté conectada la cuenta profesional de Instagram correcta.
2. En **Super Admin → Channels → Messenger**, completar **Instagram Verify Token** con otra cadena aleatoria segura y guardar.
3. En Meta → **Caso de uso API de Instagram → Configuración con inicio de sesión de Facebook**, agregar los permisos de mensajería que ofrece esa sección.
4. En los webhooks del objeto **Instagram**, configurar:
   - **URL:** `https://TU-DOMINIO-CHATWOOT/webhooks/instagram`
   - **Token:** el mismo **Instagram Verify Token** de Chatwoot.
5. Verificar y guardar. Suscribirse a `messages`, `messaging_seen` y `message_reactions` cuando estén disponibles.
6. Al conectar la página en Chatwoot, autorizar también el acceso a Instagram. Si la página ya estaba conectada antes de agregar esos permisos, reautorizarla desde Chatwoot.
