import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Float "mo:base/Float";
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import Int "mo:base/Int";
import Char "mo:base/Char";
import Option "mo:base/Option";
import Array "mo:base/Array";

actor RegistroCalificaciones {
  type Materia = {
    id: Text;
    nombre: Text;
  };

  type Carrera = {
    id: Text;
    nombre: Text;
    materias: [Materia];
  };

  type Estudiante = {
    id: Principal;
    nombre: Text;
    appat: Text;
    apmat: Text;
    grado: Int;
    grupo: Char;
    carreraId: Text;
  };

  type Calificacion = {
    materiaId: Text;
    calif: Float;
  };

  var carreras = HashMap.HashMap<Text, Carrera>(10, Text.equal, Text.hash);
  var estudiantes = HashMap.HashMap<Principal, Estudiante>(10, Principal.equal, Principal.hash);
  var calificaciones = HashMap.HashMap<Principal, [Calificacion]>(10, Principal.equal, Principal.hash);

  public func registrarCarrera(id: Text, nombre: Text, materias: [Materia]) : async Text {
    carreras.put(id, {id = id; nombre = nombre; materias = materias});
    return "Carrera Registrada Con Éxito";
  };

  public shared ({ caller }) func registrarEstudiante(nombre: Text, appat: Text, apmat: Text, grado: Int, grupo: Char, carreraId: Text): async Text {
    switch (carreras.get(carreraId)) {
      case (?carrera) {
        estudiantes.put(caller, {id = caller; nombre = nombre; appat = appat; apmat = apmat; grado = grado; grupo = grupo; carreraId = carreraId});
        return "Estudiante registrado con éxito en la carrera ${carrera.nombre}";
      };
      case null return "¡ERROR! ¡Esta carrera no existe!";
    }
  };

  public shared ({caller}) func registrarCalificacion(materiaId: Text, calif: Float) : async Text {
    switch(estudiantes.get(caller)){
      case(?estudiante) {
        //Aqui se podria agregar una verificación de la materia.
        let nuevaCalificacion : Calificacion = {
          materiaId = materiaId;
          calif = calif;
        };
        switch(calificaciones.get(caller)){
          case (?calificacionesExistentes){
            let nuevasCalificaciones = Array.append(calificacionesExistentes, [nuevaCalificacion]);
            calificaciones.put(caller, nuevasCalificaciones);
            return "Calificación Agregada";
          };
          case null {
            calificaciones.put(caller, [nuevaCalificacion]);
            return "Calificación Agregada";
          }
        };
      };
      case null return "¡ERROR! ¡EL ESTUDIANTE NO EXISTE!";
    }
  };

  public shared ({caller}) func verCalificaciones() : async ?[Calificacion] {
    return calificaciones.get(caller);
  };
};