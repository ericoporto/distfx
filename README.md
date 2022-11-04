# distfx
distortion effects script module for AGS, based on Earthbound battle effects.

<img src="https://user-images.githubusercontent.com/2244442/199853408-98184522-5c9c-4426-ad4f-34b698cc86ab.gif" width="640" height="400" style="image-rendering:pixelated;image-rendering:pixelated;">

## Usage

In a room script, link before fade in and repeatedly execute, and try the example below.

```AGS Script
DistFX fx; // somewhere with the same lifetime as the output surface while distorted
Overlay* ovr;
DynamicSprite* spr;

function room_RepExec()
{
  fx.Update(Room.GetDrawingSurfaceForBackground(), spr.GetDrawingSurface(), 2 /* effect */);
  ovr.Graphic = spr.Graphic;
}

function room_Load()
{
  if(ovr == null) {
    spr = DynamicSprite.CreateFromBackground();
    ovr = Overlay.CreateGraphical(0, 0, spr.Graphic, true);
  }
}
```

Original Earthbound effects used a per pixel approach, but due to how AGS Script drawing performs and works, this module use a tile based approach.

## Script API

### `DistFX.Update`

```AGS Script
void DistFX.Update(DrawingSurface* source, DrawingSurface* dest, int effect);
```

Draws from a source surface to a destination surface using a distortion effect.
  

### `DistFX.Reset`

```AGS Script
void DistFX.Reset();
```

Reset internal state, use on state change.


### `DistFX.DrawingTransparency`

```AGS Script
attribute int DistFX.DrawingTransparency;
```

Drawing Transparency, use for blurring the effects. Default is 0, range from 0 to 99.


### `DistFX.TileWidth`
  
```AGS Script
attribute int DistFX.TileWidth;
```

Distortion Tile Width, factor of source width, bigger is less resource intensive. Default is 64 pixels.


### `DistFX.TileHeight`

```AGS Script
attribute int DistFX.TileHeight;
```

Distortion Tile Height, factor of source height, bigger is less resource intensive. Default is 1 pixel.


## License

This code is licensed with MIT [`LICENSE`](LICENSE).

