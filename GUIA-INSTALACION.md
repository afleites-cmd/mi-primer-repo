# 📲 Guía de instalación — Billetera Pro

Tu app de gastos con usuarios, en la nube y con vista **mes a mes**.
No usa Google Sheets: usa **Supabase** (base de datos gratis) y se publica con
**GitHub Pages** (gratis). Sigue los pasos en orden. No necesitas instalar nada
en tu computadora.

Tiempo aproximado: **10–15 minutos**.

---

## Paso 1 — Crear el proyecto en Supabase (la base de datos)

1. Entra a 👉 https://supabase.com y haz clic en **Start your project** / inicia
   sesión (puedes usar tu cuenta de GitHub).
2. Clic en **New project**.
   - **Name:** `billetera` (o el nombre que quieras).
   - **Database Password:** inventa una y **guárdala** (no es la del login de la app,
     es interna de la base de datos).
   - **Region:** elige la más cercana (ej. *South America (São Paulo)*).
3. Clic en **Create new project** y espera ~2 minutos a que se cree.

---

## Paso 2 — Crear la tabla de datos

1. En tu proyecto de Supabase, menú izquierdo → **SQL Editor** → **New query**.
2. Abre el archivo **`supabase-setup.sql`** (está en este mismo proyecto),
   copia **TODO** su contenido y pégalo en el editor.
3. Clic en **Run** (o `Ctrl+Enter`). Debe decir *Success*.

> Esto crea la tabla de movimientos y la seguridad para que **cada usuario vea
> solo sus propios gastos**.

---

## Paso 3 — Permitir crear cuentas al instante (recomendado)

Por defecto Supabase pide confirmar el correo. Para que crear usuarios sea
inmediato:

1. Menú izquierdo → **Authentication** → **Sign In / Providers** (o **Providers**).
2. Abre **Email**.
3. **Desactiva** la opción **Confirm email** y guarda.

> Si prefieres mantener la confirmación por correo, déjalo activado: al crear una
> cuenta, el usuario recibirá un email para confirmar antes de poder entrar.

---

## Paso 4 — Copiar tus claves a la app

1. En Supabase, menú izquierdo → **Project Settings** (engranaje) → **API**.
2. Copia estos dos valores:
   - **Project URL** (algo como `https://xxxxxxxx.supabase.co`)
   - **anon public** (una clave larga)
3. Abre el archivo **`docs/index.html`** de este proyecto y busca cerca del final,
   dentro de `<script>`, estas dos líneas:

   ```js
   const SUPABASE_URL = "PEGA_AQUI_TU_PROJECT_URL";
   const SUPABASE_ANON_KEY = "PEGA_AQUI_TU_ANON_KEY";
   ```

   Reemplaza los textos entre comillas por tus valores. Debe quedar así (ejemplo):

   ```js
   const SUPABASE_URL = "https://abcd1234.supabase.co";
   const SUPABASE_ANON_KEY = "eyJhbGciOiJI...clave larga...";
   ```

   > La clave **anon public** es segura para poner en la web: la protección real
   > la dan las políticas del Paso 2.

---

## Paso 5 — Publicar la app en internet (GitHub Pages)

Ya tienes el repositorio `mi-primer-repo` en GitHub. Solo falta subir estos
archivos y activar Pages.

1. Sube los cambios (commit + push) de la carpeta `docs/` a la rama `main`.
   *(Si no sabes cómo, dime y te ayudo con los comandos.)*
2. En GitHub, entra a tu repo → **Settings** → **Pages**.
3. En **Source** elige **Deploy from a branch**.
4. En **Branch** elige **main** y carpeta **/docs**, y clic en **Save**.
5. Espera 1–2 minutos. GitHub te mostrará la dirección, algo como:

   ```
   https://afleites-cmd.github.io/mi-primer-repo/
   ```

¡Esa es la dirección de tu app! Ábrela en el navegador.

---

## Paso 6 — Usar e instalar en el celular

1. Abre la dirección de tu app en el navegador del celular.
2. Crea tu cuenta (pestaña **Crear cuenta**) e inicia sesión.
3. Para instalarla como app:
   - **Android (Chrome):** menú ⋮ → **Agregar a pantalla principal**.
   - **iPhone (Safari):** botón compartir → **Agregar a inicio**.

Listo: tendrás el ícono de la billetera en tu celular como una app normal. 🎉

---

## Cómo se usa

- Arriba eliges el **mes** con las flechas ‹ ›. Los totales (Ingresos, Egresos,
  Balance), las categorías y el historial cambian según el mes elegido.
- **Registrar movimiento:** elige tipo, descripción, monto, categoría y fecha.
  La app te lleva automáticamente al mes de ese movimiento.
- **🗑** elimina un movimiento.
- Cada persona que cree su cuenta tiene sus propios datos, separados del resto.

---

## ¿Algo no funciona?

- **Sale el aviso amarillo "Falta configurar":** no se pegaron bien las claves del
  Paso 4 (revisa que no quede el texto `PEGA_AQUI...`).
- **"Correo o contraseña incorrectos":** revisa los datos; si recién creaste la
  cuenta y dejaste la confirmación de correo activada (Paso 3), primero confirma
  el email.
- **No aparece la opción de instalar:** asegúrate de abrirla por la dirección
  `https://...github.io/...` (no el archivo local) y recarga la página.
