<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Aduana.Login" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Rápido Ochoa Aduanas - Iniciar Sesión</title>

    <style>
        body {
            margin: 0;
            background-color: #eaf1fb;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .login-wrapper {
            display: flex;
            background-color: #f9fbff;
            border-radius: 18px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            overflow: hidden;
            width: 950px;
            max-width: 95%;
        }

        /* PANEL IZQUIERDO */
        .left-side {
            flex: 1.2;
            background: url('Img/aduana.jpg') no-repeat center ;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding: 25px;
            position: relative;
        }

        .overlay-info {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 14px;
            padding: 18px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
        }

        .overlay-left {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logo-circle {
            background-color: #004aad;
            color: white;
            font-weight: bold;
            border-radius: 50%;
            width: 45px;
            height: 45px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .overlay-left h3 {
            margin: 0;
            font-size: 18px;
            color: #1a1a1a;
        }

        .tags {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .tag {
            background: #fff9e6;
            color: #b58a00;
            font-weight: 600;
            border-radius: 20px;
            padding: 6px 14px;
            font-size: 13px;
            border: 1px solid #ffe58a;
        }

        /* PANEL DERECHO */
        .right-side {
            flex: 1;
            background: #ffffff;
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            border-left: 1px solid #dce4f0;
        }

        .header {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header .logo-circle {
            background-color: #004aad;
            width: 40px;
            height: 40px;
            font-size: 16px;
        }

        .header h2 {
            margin: 0;
            color: #003366;
            font-size: 20px;
        }

        .right-side h3 {
            color: #002f5c;
            font-size: 24px;
            margin-top: 25px;
            margin-bottom: 10px;
        }

        .right-side p {
            color: #5f6b7a;
            margin-bottom: 30px;
        }

        label {
            font-weight: 600;
            color: #1a1a1a;
            font-size: 14px;
            display: block;
            margin-bottom: 6px;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #c9d4e5;
            border-radius: 10px;
            font-size: 15px;
            transition: 0.3s;
            outline: none;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #004aad;
            box-shadow: 0 0 5px rgba(0, 74, 173, 0.25);
        }

        .forgot {
            display: block;
            margin-top: 8px;
            color: #004aad;
            font-size: 13px;
            text-decoration: none;
        }

        .forgot:hover {
            text-decoration: underline;
        }

        .btn-login {
            width: 100%;
            background-color: #ffb100;
            color: #1a1a1a;
            border: none;
            font-weight: bold;
            font-size: 15px;
            border-radius: 10px;
            padding: 12px;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 25px;
        }

        .btn-login:hover {
            background-color: #e5a000;
        }

        .bottom-text {
            margin-top: 25px;
            text-align: center;
            font-size: 14px;
            color: #5a6779;
        }

        .bottom-text a {
            color: #004aad;
            text-decoration: none;
            font-weight: 600;
        }

        .bottom-text a:hover {
            text-decoration: underline;
        }

        #lblMensaje {
            display: block;
            text-align: center;
            margin-top: 10px;
            color: red;
            font-weight: bold;
        }

        @media (max-width: 850px) {
            .login-wrapper {
                flex-direction: column;
                width: 90%;
                height: auto;
            }
            .left-side {
                height: 240px;
            }
            .right-side {
                padding: 30px 20px;
            }
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="login-wrapper">
            <!-- Panel Izquierdo -->
            <div class="left-side">
                 <img src="Imagenes/Avion.jpg" alt="Logo Aduana" style="width:500px; height:400px"  />
                <div class="overlay-info">
                    <div class="overlay-left">
                        <div class="logo-circle">RO</div>
                        <h3>Rápido Ochoa</h3>
                    </div>
                    <div class="tags">
                        <div class="tag">Seguridad</div>
                        <div class="tag">Confiabilidad</div>
                        <div class="tag">24/7</div>
                    </div>
                </div>
            </div>

            <!-- Panel Derecho -->
            <div class="right-side">
                <div class="header">
                    <div class="logo-circle">RO</div>
                    <h2>Rápido Ochoa Aduanas</h2>
                </div>

                <h3>Inicia sesión</h3>
                <p>Accede a tu panel de pasajero para gestionar trámites y seguimiento.</p>

                <div class="form-group">
                    <label for="txtUsuario">Usuario o Correo Electrónico</label>
                    <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" />
                </div>

                <div class="form-group">
                    <label for="txtContrasena">Contraseña</label>
                    <asp:TextBox ID="txtContrasena" runat="server" TextMode="Password" CssClass="form-control" />
                </div>

                <a href="sistema.aspx" class="forgot">volver</a>

                <asp:Button ID="btnIngresar" runat="server" Text="Iniciar Sesión" CssClass="btn-login" OnClick="btnIngresar_Click" />

                <asp:Label ID="lblMensaje" runat="server"></asp:Label>

              
            </div>
        </div>
    </form>
</body>
</html>

