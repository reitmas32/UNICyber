class ComputerStates {
  static int disponible = 0;
  static int mantenimiento = 1;
  static int reparacion = 2;
  static int proyecto = 3;

  static String getStateLable(int state) {
    switch (state) {
      case 0:
        return 'Disponible';
      case 1:
        return 'Mantenimiento';
      case 2:
        return 'Reparacion';
      case 3:
        return 'Proyecto';
      default:
        return 'Disponible';
    }
  }
}
