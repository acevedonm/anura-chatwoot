# Anura — Base de Chatwoot y flujo Git

AC-003. Basado en DEC-023 y DEC-024 de `ANURA_CONNECT_ARCHITECTURE_v1_1.md`.
La tarea referencia la versión 1.2 del documento, aún pendiente de contrastar.

## Base estable

- Repositorio de Anura: https://github.com/acevedonm/anura-chatwoot
- Repositorio oficial: https://github.com/chatwoot/chatwoot
- Rama estable de Anura: `master`.
- Versión inicial: **Chatwoot v4.19.1**.
- Commit oficial: `caab07a8f00032d5205b5a5d7e2eb0ba2f3d2d82`.
- Release: https://github.com/chatwoot/chatwoot/releases/tag/v4.19.1

Al revisar el fork el 4 de noviembre de 2026, `origin/master` coincide con ese
commit. Los cambios propios se incorporarán sobre esa base. El tag oficial se
conserva sin moverlo; cada actualización deberá registrar aquí su nuevo tag y
commit. Esta elección de base no modifica ningún despliegue existente.

## Remotos

Cada desarrollador configura los remotos en su propia copia local; esta
configuración no se comparte al subir commits.

```sh
git clone https://github.com/acevedonm/anura-chatwoot.git
cd anura-chatwoot
git remote add upstream https://github.com/chatwoot/chatwoot.git
git fetch upstream --tags
git remote -v
```

`origin` apunta al fork de Anura y recibe nuestros cambios. `upstream` apunta al
repositorio oficial y permite consultar y descargar sus versiones. Si `upstream`
ya existe, comprobar su URL con `git remote -v` antes de configurarlo de nuevo.

## Trabajo diario y pull requests

1. Crear una rama por tarea desde `origin/master`, por ejemplo
   `feat/ac-010-branding`, `fix/ac-020-envio` o `chore/ac-003-git-flow`.
2. Realizar el cambio mínimo necesario y las verificaciones correspondientes.
3. Subir la rama a `origin` y abrir un PR con destino a **`master` del fork de
   Anura**, explicando qué cambia y cómo se verificó.
4. Integrar el PR después de su revisión; no trabajar directamente sobre `master`.

Ejemplo de inicio de tarea:

```sh
git fetch origin
git switch -c feat/ac-010-branding origin/master
```

El fork conserva `develop`, que contiene desarrollo de Chatwoot distinto de la
base estable. No se utiliza como base de las tareas de Anura ni se mezcla
directamente en `master`. Aunque GitHub la tenga como rama predeterminada,
seleccionar explícitamente `master` como destino de los PR de Anura.

## Actualizaciones de Chatwoot

1. Descargar los tags oficiales con `git fetch upstream --tags` y elegir una
   versión estable tras revisar sus notas de release.
2. Crear `update/chatwoot-X.Y.Z` desde `origin/master`.
3. Integrar el tag elegido en esa rama mediante `git merge vX.Y.Z`, conservando
   los cambios de Anura y resolviendo los conflictos que aparezcan.
4. Verificar la actualización, revisar las migraciones y actualizar en este
   documento el tag y commit de la nueva base.
5. Abrir un PR a `master` para revisión antes de integrar y planificar el despliegue.

Las actualizaciones se eligen por tag o commit exacto; no se sigue automáticamente
`develop` ni una imagen `latest`. Mantener los avisos de licencia del proyecto
original y limitar los cambios propios al alcance acordado para Community.
