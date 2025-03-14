import React, { useState, useEffect } from "react";
import { verCalificacion, agregarCalificacion } from "./api";

function App() {
  const [calificacion, setCalificacion] = useState([]);
  const [materia, setMateria] = useState("");
  const [calif, setCalif] = useState("");

  useEffect(() => {
    async function cargarDatos() {
      const datos = await verCalificacion();
      setCalificacion(datos || []);
    }
    cargarDatos();
  }, []);

  const handleAgregarCalificacion = async () => {
    await agregarCalificacion(materia, parseFloat(nota));
    setMateria("");
    setCalif("");
  };

  return (
    <div>
      <h1>Mis Calificaciones</h1>
      <ul>
        {calificacion.map((c, index) => (
          <li key={index}>{c.materiaId}: {c.calif}</li>
        ))}
      </ul>
      <h2>Agregar Calificación</h2>
      <input
        type="text"
        placeholder="Materia ID"
        value={materia}
        onChange={(e) => setMateria(e.target.value)}
      />
      <input
        type="number"
        placeholder="Calificación"
        value={calif}
        onChange={(e) => setCalif(e.target.value)}
      />
      <button onClick={handleAgregarCalificacion}>Agregar</button>
    </div>
  );
}

export default App;
