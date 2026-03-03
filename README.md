

💀 Golden Double Action - Permanent Kick System

Sistema de morte permanente com Revolver Double Action para servidores FiveM.

Quando um jogador é morto com a arma configurada, ele é automaticamente kickado do servidor e um log completo é enviado para o Discord.

Compatível com:

ESX

QBCore

Qbox

Creative (vRP)



---

🔥 Funcionalidades

✅ Detecção 100% server-side (anti trigger)

✅ Sem eventos públicos exploráveis

✅ Kick automático ao morrer pela arma configurada

✅ Log completo no Discord

✅ Identificação por:

CitizenID (QBCore / Qbox)

Identifier (ESX)

Passport (Creative)

Steam

License

Discord


✅ Totalmente configurável



---

📁 Estrutura

golden_revolver/
│
├── fxmanifest.lua
├── config.lua
└── server.lua


---

⚙️ Instalação

1. Coloque a pasta golden_revolver dentro de resources/


2. Configure o config.lua


3. Adicione no server.cfg:



ensure golden_revolver

4. Reinicie o servidor




---

🛠 Configuração

Edite o arquivo config.lua:

Config = {}

-- Framework: "esx", "qbcore", "qbox", "creative"
Config.Framework = "creative"

-- Arma que ativa o sistema
Config.Weapon = "WEAPON_DOUBLEACTION"

-- Mensagem ao ser kickado
Config.KickMessage = "Sua história chegou ao fim..."

-- Delay antes do kick (ms)
Config.DelayBeforeKick = 4000

-- Webhook do Discord
Config.DiscordWebhook = "COLE_SEU_WEBHOOK_AQUI"

Config.LogTitle = "💀 MORTE PERMANENTE"
Config.LogColor = 16711680


---

🧠 Como Funciona

O sistema usa:

gameEventTriggered

CEventNetworkEntityDamage


Isso significa:

Não depende do client

Não pode ser ativado por TriggerServerEvent

Só ativa quando realmente houver morte

Valida arma utilizada

Valida atacante


Sistema totalmente server-side.


---

📄 Exemplo de Log no Discord

💀 VÍTIMA
Nome: PlayerX
ID Personagem: 582
Steam: steam:11000010xxxxx
License: license:abcdxxxxx
Discord: @usuario

🔫 ASSASSINO
Nome: PlayerY
ID Personagem: 91
Steam: steam:11000010yyyy
License: license:abcdyyyy
Discord: @usuario


---

🔒 Segurança

✔ Anti-trigger

✔ Server-side

✔ Sem exploit manual

✔ Sem ban automático

✔ Apenas kick



---

🧩 Compatibilidade

Framework	Suporte

ESX	✅
QBCore	✅
Qbox	✅
Creative	✅



---

🚀 Melhorias Futuras (Opcional)

Sistema de permissão (ex: apenas polícia)

Execução com animação antes do kick

Blackout na tela

Integração com banco de dados

Restrição por skin dourada específica

Sistema de "pena de morte" autorizada



---

👨‍💻 Autor

Vitor Santos


---

📜 Licença

Uso livre para servidores FiveM.
Não revender sem autorização.
