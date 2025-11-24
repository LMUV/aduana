<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sistema.aspx.cs" Inherits="aduana.sistema" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aerolínea Rápido Ocho</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #ffffff;
            color: #003366;
        }
        header {
            background-color: #003399;
            padding: 20px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        nav a {
            margin: 0 15px;
            text-decoration: none;
            color: white;
            font-weight: bold;
        }
        nav a:hover {
            color: #ffcc00;
        }
        .hero {
            background-image: url('https://images.unsplash.com/photo-1529074963764-98f45c47344b');
            background-size: cover;
            background-position: center;
            height: 450px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            text-shadow: 2px 2px 6px #000;
            font-size: 48px;
            font-weight: bold;
        }
        .contenedor {
            padding: 40px;
            text-align: center;
        }
        .seccion {
            margin-bottom: 40px;
        }
        .btn-login {
            display: inline-flex;
            align-items: center;
            background-color: #0055cc;
            color: white;
            padding: 15px 25px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 20px;
            font-weight: bold;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
            transition: 0.3s;
        }
        .btn-login:hover {
            background-color: #003f99;
            transform: scale(1.05);
        }
        .btn-login img {
            width: 35px;
            margin-right: 10px;
        }
        .card {
            background: #e6f0ff;
            padding: 20px;
            border-radius: 15px;
            width: 300px;
            margin: 20px auto;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
    <header>
        <h1>Rápido Ochoa Airlines</h1>
        <nav>
            <a href="#nosotros">Nosotros</a>
            <a href="#mision">Misión</a>
            <a href="#vision">Visión</a>
            <a href="#vuelos">Vuelos</a>
            <a href="#contacto">Contacto</a>
        </nav>
    </header>

    <div class="hero">Vuela más alto con Rápido Ochoa</div>

    <div class="contenedor">

        <div class="seccion" id="nosotros">
            <h2>Nosotros</h2>
            <div class="card">
                <img src="Imagenes/Avion.jpg"  width="100%" style="border-radius:10px;">
                <p>Somos una aerolínea comprometida con ofrecer vuelos seguros, cómodos y rápidos en todo el país.</p>
            </div>
        </div>

        <div class="seccion" id="mision">
            <h2>Misión</h2>
            <p>Garantizar experiencias de viaje excepcionales a través de innovación, seguridad y servicio humano.</p>
        </div>

        <div class="seccion" id="vision">
            <h2>Visión</h2>
            <p>Ser la aerolínea líder en conectividad aérea con altos estándares de calidad y eficiencia.</p>
        </div>

        <div class="seccion" id="contacto">
             <h2>Datos de Contacto</h2>
    <h3>Direccion</h3>
    <p>Medillin</p>
    <h3>Teléfono</h3>
     <p>+57 (705) 555 -1201</p>



 <h3>Email</h3>
<p>RadigoOchoa@Airlines+.com</p>
      
</div>

        <div class="seccion" id="vuelos">
            <h2>Vuelos Disponibles</h2>
            <table style="width:90%; margin:auto; border-collapse: collapse; font-size:18px;">
                <tr style="background:#003399; color:white;">
                    <th>Vuelo</th><th>Aerolínea</th><th>Origen</th><th>Destino</th><th>Fecha</th><th>Hora</th><th>Puerta</th><th>Estado</th>
                </tr>
                <tr><td>R8-701</td><td>Rápido 8</td><td>Bogotá</td><td>Madrid, España</td><td>2024-10-27</td><td>14:30</td><td>A12</td><td>A tiempo</td></tr>
                <tr style="background:#e6f0ff;"><td>R8-205</td><td>Rápido 8</td><td>Medellín</td><td>Nueva York, EE. UU.</td><td>2024-10-27</td><td>16:00</td><td>B05</td><td>Embarcando</td></tr>
                <tr><td>R8-910</td><td>Rápido 8</td><td>Cali</td><td>París, Francia</td><td>2024-10-27</td><td>18:15</td><td>C03</td><td>Retrasado</td></tr>
                <tr style="background:#e6f0ff;"><td>R8-432</td><td>Rápido 8</td><td>Cartagena</td><td>Miami, EE. UU.</td><td>2024-10-27</td><td>19:45</td><td>D01</td><td>A tiempo</td></tr>
                <tr><td>R8-118</td><td>Rápido 8</td><td>Bogotá</td><td>Londres, Inglaterra</td><td>2024-10-27</td><td>21:00</td><td>A08</td><td>A tiempo</td></tr>
                <tr style="background:#e6f0ff;"><td>R8-607</td><td>Rápido 8</td><td>Medellín</td><td>Ciudad de México</td><td>2024-10-28</td><td>08:30</td><td>B02</td><td>Programado</td></tr>
                <tr><td>R8-880</td><td>Rápido 8</td><td>Cali</td><td>Sídney, Australia</td><td>2024-10-28</td><td>10:00</td><td>C05</td><td>Programado</td></tr>
                <tr style="background:#e6f0ff;"><td>R8-315</td><td>Rápido 8</td><td>Cartagena</td><td>Roma, Italia</td><td>2024-10-28</td><td>12:10</td><td>D03</td><td>Programado</td></tr>
                <tr><td>R8-555</td><td>Rápido 8</td><td>Bogotá</td><td>Toronto, Canadá</td><td>2024-10-28</td><td>15:20</td><td>A10</td><td>Programado</td></tr>
                <tr style="background:#e6f0ff;"><td>R8-777</td><td>Rápido 8</td><td>Barranquilla</td><td>São Paulo, Brasil</td><td>2024-10-28</td><td>17:00</td><td>B07</td><td>Programado</td></tr>
            </table>
        </div>

        <div class="seccion" style="margin-top:50px;">
            <a class="btn-login" href="Login.aspx">
                <img src="https://cdn-icons-png.flaticon.com/512/69/69589.png">
                Ingreso Aduanas
            </a>
        </div>


      

    </div>

    <footer style="background:#003399; color:white; padding:30px; text-align:center; margin-top:40px;">
        <h3>Síguenos en nuestras redes</h3>
        <div style="margin-top:15px;">
         
                 <a href="https://www.facebook.com/?locale=es_LA" style="margin:0 15px;">
                <img src="https://cdn-icons-png.flaticon.com/512/733/733547.png" width="45" />
            </a>
             
                   <a href="https://www.instagram.com/" style="margin:0 15px;">
                <img src="https://cdn-icons-png.flaticon.com/512/174/174855.png" width="45" />
            </a>
            <a href="https://www.youtube.com/?app=desktop&hl=es" style="margin:0 15px;">
                <img src="https://cdn-icons-png.flaticon.com/512/1384/1384060.png" width="45" />
            </a>
        </div>
        <p style="margin-top:20px; font-size:14px;">© 2024 Rápido Ocho Airlines - Todos los derechos reservados</p>
    </footer>
</body>
</html>
