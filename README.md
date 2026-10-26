## Decisiones Importantes que tome produciendo el codigo

**Separe las responsabilidades en distintas clases y objetos (Productora, Asistente, Entrada, Banda, abonoVip, abonoFan) para que cada uno se encargue de una responsabilidad especifica y facilitar el mantenimiento y la lectura del codigo.

**Use herencia y polimorfismo para modelar los distintos tipos de banda y agruparlas a todas en una clase Banda, de las cuales cada una redefine sus metodos y evita usar condicionales para distinguir cada tipo.

**En cuanto a los abonos decidi que cada uno tenga su propio metodo cantAPagar para que asistente no tenga conocer las reglas del descuento de cada uno y asi solo se encarga del calculo.

## Conceptos de la materia 

### Polimorfismo
**Lo utilize en abonoFan/AbonoVip y BandaRock/BandaTrap/BandaIndie para que el asistente tratara igual a cualquier abono y la productora tratara igual a cualquier banda, evitando asi utilizar if y agregar casos nuevos sin modificar el codigo ya existente.

### Herencia
**BandaRock, BandaTrap y BandaIndie herendan la clase Banda ya que las tres compraten nombre, presupuesto y canon, de esta forma ese codigo se escribe solo una vez.

### Colecciones y Orden Superior
**Se usan en entradasAnioAnterior, filter, bandasConEntrada, map, asSet, etc. para resolver consultas en una linea sin recorrer las listas a mano.

### Manejo de errores
**Se puede ver en puedeComprarEntrada donde utilizo self.error("..."), en donde si el asistente no tiene saldo positivo, se le envia un mensaje claro para cortar la compra. La validacion se hace antes de que se cree la entrada, para que una compra fallida no deje el estado a medias.

### Clase y metodos Abstractos
**Se puede ver en la clase Banda con gastoExtra y popularidad los cuales no tienen cuerpo, al ser abstractos obligan a cada subclase de banda a definir lo que les corresponde.
