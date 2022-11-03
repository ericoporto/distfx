# distfx
distortion effects script module for AGS, based on Earthbound battle effects.

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

## Script API


## License

This code is licensed with MIT [`LICENSE`](LICENSE).

