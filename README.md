# nix-shell-test

Proyecto de ejemplo que muestra **dos formas** de crear entornos de desarrollo reproducibles con Nix:

1. **`flake-example/`** — usando *Nix Flakes* directamente (`flake.nix` + `mkShell`).
2. **`devenv-example/`** — usando *devenv* (que a su vez se construye sobre flakes, pero con una capa de conveniencia).

Ambos proyectos definen los **mismos tres entornos** para comparar lado a lado:

| Subdirectorio | Stack            | Paquete                 |
| ------------- | ---------------- | ----------------------- |
| `backend`     | .NET 7 (EOL)     | `pkgs.dotnet-sdk_7`     |
| `frontend`    | Node.js 20       | `pkgs.nodejs_20`        |
| `movil`       | Flutter 3.38.3   | `pkgs.flutter338`       |

---

## Requisitos previos

- [Nix](https://nixos.org/download/) con *flakes* habilitado:
  ```bash
  # /etc/nix/nix.conf
  experimental-features = nix-command flakes
  ```
- Para **devenv**: instalar el paquete `devenv` desde cachix:
  ```bash
  nix profile install --accept-flake-config nixpkgs#devenv
  # o seguir la guía oficial: https://devenv.sh/getting-started/
  ```

---

## Cómo ejecutar el entorno de desarrollo

### Con flakes (`flake-example/`)

Entrar al directorio y usar `nix develop`:

```bash
cd flake-example/backend
nix develop
```

En este ejemplo **cada subdirectorio tiene su propio `flake.nix`**, así que también puedes invocar el shell del backend sin cambiar de directorio:

```bash
nix develop flake-example/backend#default
```

### Con devenv (`devenv-example/`)

Devenv lee el directorio actual, así que también hay que entrar en cada subproyecto:

```bash
cd devenv-example/backend
devenv shell
```

Devenir crea un `devenv.lock` (equivalente a `flake.lock`) que fija las versiones la primera vez.

---

## Diferencias principales

| Aspecto                  | Nix Flakes                                       | devenv                                                        |
| ------------------------ | ------------------------------------------------ | ------------------------------------------------------------- |
| **Declaración**          | `flake.nix` en Nix puro                          | `devenv.nix` más legible + `devenv.yaml`                      |
| **Curva de aprendizaje** | Alta: exige conocer el lenguaje Nix              | Baja: sintaxis más parecida a config/declarativa             |
| **Bloqueo de versiones** | `flake.lock`                                     | `devenv.lock`                                                 |
| **Entorno declarativo**  | Solo paquetes (con `mkShell`)                    | Además servicios, pre-commit, procesos, env vars, scripts     |
| **Config de nixpkgs**    | `config.permittedInsecurePackages = [...]`       | `nixpkgs.permitted_insecure_packages: [...]` en `devenv.yaml` |
| **Servicios (DB, Redis)**| Hay que escribirlos a mano                       | Soporte nativo (`services.postgres`, `services.redis`, etc.)  |
| **Empaquetado**          | Buena integración con el resto de outputs flake  | Enfocado en dev; la publicación se deja a flakes              |
| **Flexibilidad**         | Total (accedes al Nix subyacente)                | Cómoda, pero limitada a lo que el módulo expone               |

### ¿Cuándo usar cada uno?

- **Nix Flakes**: cuando quieras control total, publicar paquetes/bibliotecas, o ya domines Nix. Es el estándar de bajo nivel.
- **devenv**: cuando quieras un entorno de desarrollo rápido de configurar y mantener, especialmente si necesitas servicios o hooks de git sin escribir Nix manual. Internamente sigue usando flakes, así que **no está en contraposición: es una capa encima**.

En resumen: **los flakes son el motor; devenv es la comodidad encima del motor.**
