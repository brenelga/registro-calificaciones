import React, {useState, useEffect} from "react"
import { verCalificacion, agregarCalificacion } from "./api"

function App() {
  const [calificaciones, setCalificaciones] = useState([]);
  const [materia, setMateria] = useState("");
  const [calif, setCalif] = useState("");
  
  useEffect(() => {
    async function cargarDatos() {
      const datos = await verCalificacion();
      setCalificaciones(datos || []);
    }
    cargarDatos();
  }, []);

  const handleAgregarCalificacion = async () => {
    await agregarCalificacion(materia, parseFloat(calif));
    setMateria("");
    setCalif("");
  };

  return(
    <div>
      <h1>Mis Calificaciones</h1>
      <ul>
        {calificaciones.map((c, index) => (
          <li key={index}>{c.materiaId}: {c.calif}</li>
        ))}
      </ul>
    </div>
  )
}

export default App
