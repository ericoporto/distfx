// DistFX Module Header

/// DistFX object
struct DistFX {
  /// Distortion Tile Width, factor of source width, bigger is less resource intensive (default is 64 pixels)
  int TileWidth;
  
  /// Distortion Tile Height, factor of source height, bigger is less resource intensive (default is 1 pixel)
  int TileHeight;
  
  /// Draws from a source surface to a destination surface using a distortion effect
  import void Update(DrawingSurface* source, DrawingSurface* dest, int effect);
  
  /// Reset internal state, use on state change
  import void Reset();
  
  /// Drawing Transparency, use for blurring the effects (defailt is 0, range from 0 to 99)
  import attribute int DrawingTransparency;
  import int get_DrawingTransparency(); // $AUTOCOMPLETEIGNORE$
  import void set_DrawingTransparency(int value); // $AUTOCOMPLETEIGNORE$
  
  // private internals  
  protected int _drawing_transparency; // $AUTOCOMPLETEIGNORE$
  protected int _ticks; // $AUTOCOMPLETEIGNORE$
  protected int _prev_fx; // $AUTOCOMPLETEIGNORE$
  protected bool _reverse_ticks; // $AUTOCOMPLETEIGNORE$
};