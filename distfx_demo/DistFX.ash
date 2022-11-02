// new module header

struct DistFX {
  int TileWidth;
  int TileHeight;
  import void Update(int effect, DrawingSurface* source, DrawingSurface* dest);
  
  // private internals  
  protected int _ticks; // $AUTOCOMPLETEIGNORE$
  protected int _prev_fx; // $AUTOCOMPLETEIGNORE$
};