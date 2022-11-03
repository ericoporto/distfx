// DistFX Module Header
// Version 0.1.0

/// DistFX object
struct DistFX {  
  /// Draws from a source surface to a destination surface using a distortion effect
  import void Update(DrawingSurface* source, DrawingSurface* dest, int effect);
  
  /// Reset internal state, use on state change
  import void Reset();
  
  // Attributes
  
  /// Drawing Transparency, use for blurring the effects (default is 0, range from 0 to 99)
  import attribute int DrawingTransparency;
  import int get_DrawingTransparency(); // $AUTOCOMPLETEIGNORE$
  import void set_DrawingTransparency(int value); // $AUTOCOMPLETEIGNORE$
  
  /// Distortion Tile Width, factor of source width, bigger is less resource intensive (default is 64 pixels)
  import attribute int TileWidth;
  import int get_TileWidth(); // $AUTOCOMPLETEIGNORE$
  import void set_TileWidth(int value); // $AUTOCOMPLETEIGNORE$
  
  /// Distortion Tile Height, factor of source height, bigger is less resource intensive (default is 1 pixel)
  import attribute int TileHeight;
  import int get_TileHeight(); // $AUTOCOMPLETEIGNORE$
  import void set_TileHeight(int value); // $AUTOCOMPLETEIGNORE$
  
  // private internals
  protected int _tile_width; // $AUTOCOMPLETEIGNORE$
  protected int _tile_height; // $AUTOCOMPLETEIGNORE$
  protected int _drawing_transparency; // $AUTOCOMPLETEIGNORE$
  protected int _ticks; // $AUTOCOMPLETEIGNORE$
  protected int _prev_fx; // $AUTOCOMPLETEIGNORE$
  protected bool _reverse_ticks; // $AUTOCOMPLETEIGNORE$
};
