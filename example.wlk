object productora { //puede cambiar el valor del impuesto
  var property impuesto = 0
  const property asistentes = []
  const property bandas = []

  method impuesto(nuevoImpuesto) {
    impuesto = nuevoImpuesto
  }

  method impuesto() = impuesto

  //reportes
  method gananciaTotal() = self.recaudacion() - self.presupuestoTotalBandas()
  method presupuestoTotalBandas() = bandas.sum({ banda => banda.presupuesto() })
  method recaudacion() = self.entradasVendidas().sum({ entrada => entrada.precioPublico() })
  method entradasVendidas() = asistentes.flatMap({ asistente => asistente.historialEntradas() })

  method cantidadEntradasVendidas() = self.entradasVendidas().size()

  method bandaMasPopular() = bandas.max({ banda => self.entradasVendidasDe(banda) })
  method entradasVendidasDe(banda) = self.entradasVendidas().count({ entrada => entrada.banda() == banda })

  //bonificacion
  method bonificarAsistentesVips() {
    asistentes.forEach({ asistente => asistente.bonificarAbono() })
  }
}

class Entrada {
  const property banda
  const property fecha
  const property precioBase = 1000

  method precioPublico() = precioBase + productora.impuesto()
}

class Asistente {
  const property abono
  const property historialEntradas = [] //inicialmente no tiene ninguna
  var property dineroDisponible //puede ser negativo

  method compraEntradas(banda, fecha) {
    self.puedeComprarEntrada()
    const entrada = new Entrada(banda = banda, fecha = fecha)
    self.pagar(entrada)
    self.agregarEnHistorial(entrada)
  }

  method puedeComprarEntrada() {
    if (!self.tieneSaldoPositivo()) {
      self.error("No tiene saldo suficiente para realizar la compra")
    }
  }

  method tieneSaldoPositivo() = dineroDisponible > 0

  method pagar(entrada) {
    dineroDisponible -= abono.cantAPagar(entrada)
  }

  method agregarEnHistorial(entrada) {
    historialEntradas.add(entrada)
  }

  method entradasAnioAnterior() = historialEntradas.filter({ entrada => entrada.fecha().year() == new Date().year() - 1 })

  method bandasConEntrada() = historialEntradas.map({ entrada => entrada.banda().nombre() }).asSet()

  method bonificarAbono() {
    abono.bonificar()
  }
}

object abonoFan {
  method cantAPagar(entrada) = entrada.precioPublico()

  method bonificar() {} //no tiene descuento, así que no hace nada
}

class AbonoVip {
  var property descuento //porcentaje

  method cantAPagar(entrada) = entrada.precioPublico() * (100 - descuento) / 100

  method bonificar() {
    descuento += 1
  }
}

class Banda {
  const property nombre
  const property canonBase = 1000000

  method presupuesto() = self.canon() + self.gastoExtra()

  method canon() = canonBase

  method gastoExtra()

  method popularidad()
}

class BandaRock inherits Banda {
  var property solosDeGuitarra

  override method gastoExtra() = 10000

  override method popularidad() = 100 * solosDeGuitarra
}

class BandaTrap inherits Banda {
  var property tieneHielo

  override method gastoExtra() = 0

  override method popularidad() = if (tieneHielo) 1000 else 0

  override method canon() = super() * self.popularidad()
}

class BandaIndie inherits Banda {
  const property instrumentos 

  override method popularidad() = 3.14 * nombre.length()

  override method gastoExtra() = 500 * instrumentos.size()
}