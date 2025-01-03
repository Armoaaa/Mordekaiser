namespace Mordekaiser.Core;

public interface IDao
{
    // Métodos de alta
    void AltaServidor(Servidor servidor);
    void AltaCuenta(Cuenta cuenta);
    void AltaRangoLol(RangoLol rangoLol);
    void AltaRangoValorant(RangoValorant rangoValorant);
    void AltaCuentaLol(CuentaLol cuentaLol);
    void AltaCuentaValorant(CuentaValorant cuentaValorant);
    void AltaTipoObjeto(TipoObjeto tipoObjeto);
    void AltaObjeto(Objeto objeto);
    void AltaInventario(Inventario inventario);

    // Métodos de obtención
    IEnumerable<Servidor> ObtenerServidores();
    Servidor? ObtenerServidor(byte a);
    RangoLol? ObtenerRangoLol(byte b);
    IEnumerable<RangoLol> ObtenerRangosLol();
    IEnumerable<RangoValorant> ObtenerRangosValorant();
    IEnumerable<(int IdCuenta, int NivelLol)> ObtenerNivelesLol();
    IEnumerable<(int IdCuenta, int NivelValorant)> ObtenerNivelesValorant();
    IEnumerable<Cuenta> ObtenerCuenta(); 
    IEnumerable<CuentaLol> ObtenerCuentasLol(); 
    IEnumerable<CuentaValorant> ObtenerCuentasValorant();
    void BajaCuentaLol(uint idCuenta);
    void BajaCuenta(uint Cuenta);
    void BajaCuentaValorant(int idCuenta);
    void BajaServidor(byte idServidor);
    void BajaObjeto(ushort idObjeto);

    // Método de login
    Cuenta? Login(string nombreUsuario, string contrasena);

    // Método de obtención de objetos
    IEnumerable<Objeto> ObtenerObjetos();
}
