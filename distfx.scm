AGSScriptModule    eri0o Distortion Effects distfx 0.2.0 kC  // DistFX Module Script
//
// MIT License
//
// Copyright (c) 2022 Érico Porto
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#define D_FORMAT_FIX  "%.6f"

enum DistType {
  eDT_None = 0,
  eDT_Hori, // Horizontal
  eDT_HInt, // Horizontal Interlaced
  eDT_Vert, // Vertical
  eDT_Rand  // Randomic Spooky
};

managed struct DistCfg {
  DistType type;
  float ampl;
  float ampl_accel;
  float s_freq;
  float s_freq_accel;
  float compr;
  float compr_accel;
  float speed;
};

enum FX {
  eDistFX_Count = 135
};

float _d_c1;
float _d_c2;
float _d_c3;
DistCfg* _fx_rom[eDistFX_Count];

void _set_fx_rom(int index, DistType type, int t_ampl, int t_ampl_accel, int t_freq, int t_freq_accel, int t_compr, int t_compr_accel, int t_speed)
{
  DistCfg* fx = new DistCfg;
  fx.type = type;
  fx.ampl = IntToFloat(t_ampl);
  fx.ampl_accel = IntToFloat(t_ampl_accel);
  fx.s_freq = IntToFloat(t_freq);
  fx.s_freq_accel = IntToFloat(t_freq_accel);
  fx.compr = IntToFloat(t_compr);
  fx.compr_accel = IntToFloat(t_compr_accel);
  fx.speed = IntToFloat(t_speed);
  _fx_rom[index] = fx;
}

void _distfx_init()
{
  // N.B. these values should be "short," and must have a specific precision.
  // this seems to effect backgrounds with distortEffect == 1
  String str_c1 = String.Format(D_FORMAT_FIX, (1.0 / 512.0));
  String str_c2 = String.Format(D_FORMAT_FIX, (8.0 * Maths.Pi / (1024.0 * 256.0)));
  String str_c3 = String.Format(D_FORMAT_FIX, (Maths.Pi / 60.0));

  _d_c1 = str_c1.AsFloat;
  _d_c2 = str_c2.AsFloat;
  _d_c3 = str_c3.AsFloat;

  _set_fx_rom(0,   eDT_None, 0,     0,     0,    0,     0,     0,     0);
  _set_fx_rom(1,   eDT_Hori, 2048,  0,     1024, 0,     0,     0,     2);
  _set_fx_rom(2,   eDT_Hori, 4096,  0,     1024, 0,     0,     0,     2);
  _set_fx_rom(3,   eDT_Hori, 8192,  0,     1024, 0,     0,     0,     2);
  _set_fx_rom(4,   eDT_Hori, 16384, 0,     1024, 0,     0,     0,     2);
  _set_fx_rom(5,   eDT_Hori, 2048,  0,     768,  0,     0,     0,     2);
  _set_fx_rom(6,   eDT_Hori, 4096,  0,     768,  0,     0,     0,     2);
  _set_fx_rom(7,   eDT_Hori, 8192,  0,     768,  0,     0,     0,     2);
  _set_fx_rom(8,   eDT_Hori, 16384, 0,     768,  0,     0,     0,     2);
  _set_fx_rom(9,   eDT_Hori, 2048,  0,     512,  0,     0,     0,     2);
  _set_fx_rom(10,  eDT_Hori, 4096,  0,     512,  0,     0,     0,     2);
  _set_fx_rom(11,  eDT_Hori, 8192,  0,     512,  0,     0,     0,     2);
  _set_fx_rom(12,  eDT_Hori, 16384, 0,     512,  0,     0,     0,     2);
  _set_fx_rom(13,  eDT_Hori, 2048,  0,     256,  0,     0,     0,     2);
  _set_fx_rom(14,  eDT_Hori, 4096,  0,     256,  0,     0,     0,     2);
  _set_fx_rom(15,  eDT_Hori, 8192,  0,     256,  0,     0,     0,     2);
  _set_fx_rom(16,  eDT_Hori, 16384, 0,     256,  0,     0,     0,     2);
  _set_fx_rom(17,  eDT_Hori, 32768, 0,     1024, 0,     0,     0,     2);
  _set_fx_rom(18,  eDT_Hori, 32768, 0,     512,  0,     0,     0,     2);
  _set_fx_rom(19,  eDT_Hori, 65535, 0,     512,  0,     0,     0,     2);
  _set_fx_rom(20,  eDT_HInt, 2048,  0,     1024, 0,     0,     0,     2);
  _set_fx_rom(21,  eDT_HInt, 4096 , 0,     1024, 0,     0,     0,     2);
  _set_fx_rom(22,  eDT_HInt, 8192,  0,     1024, 0,     0,     0,     2);
  _set_fx_rom(23,  eDT_HInt, 16384, 0,     1024, 0,     0,     0,     2);
  _set_fx_rom(24,  eDT_HInt, 2048,  0,     768,  0,     0,     0,     2);
  _set_fx_rom(25,  eDT_HInt, 4096,  0,     768,  0,     0,     0,     2);
  _set_fx_rom(26,  eDT_HInt, 8192,  0,     768,  0,     0,     0,     2);
  _set_fx_rom(27,  eDT_HInt, 16384, 0,     768,  0,     0,     0,     2);
  _set_fx_rom(28,  eDT_HInt, 2048,  0,     512,  0,     0,     0,     2);
  _set_fx_rom(29,  eDT_HInt, 4096,  0,     512,  0,     0,     0,     2);
  _set_fx_rom(30,  eDT_HInt, 8192,  0,     512,  0,     0,     0,     2);
  _set_fx_rom(31,  eDT_HInt, 16384, 0,     512,  0,     0,     0,     2);
  _set_fx_rom(32,  eDT_HInt, 2048,  0,     256,  0,     0,     0,     2);
  _set_fx_rom(33,  eDT_HInt, 4096,  0,     256,  0,     0,     0,     2);
  _set_fx_rom(34,  eDT_HInt, 8192,  0,     256,  0,     0,     0,     2);
  _set_fx_rom(35,  eDT_HInt, 16384, 0,     256,  0,     0,     0,     2);
  _set_fx_rom(36,  eDT_HInt, 32768, 0,     1024, 0,     0,     0,     2);
  _set_fx_rom(37,  eDT_HInt, 32768, 0,     512,  0,     0,     0,     2);
  _set_fx_rom(38,  eDT_HInt, 65535, 0,     512,  0,     0,     0,     2);
  _set_fx_rom(39,  eDT_Vert, 2048,  0,     1024, 0,     0,     0,     2);
  _set_fx_rom(40,  eDT_Vert, 4096,  0,     1024, 0,     0,     0,     2);
  _set_fx_rom(41,  eDT_Vert, 8192,  0,     1024, 0,     0,     0,     2);
  _set_fx_rom(42,  eDT_Vert, 16384, 0,     1024, 0,     0,     0,     2);
  _set_fx_rom(43,  eDT_Vert, 2048,  0,     768,  0,     0,     0,     2);
  _set_fx_rom(44,  eDT_Vert, 4096,  0,     768,  0,     0,     0,     2);
  _set_fx_rom(45,  eDT_Vert, 8192,  0,     768,  0,     0,     0,     2);
  _set_fx_rom(46,  eDT_Vert, 16384, 0,     768,  0,     0,     0,     2);
  _set_fx_rom(47,  eDT_Vert, 2048,  0,     512,  0,     0,     0,     2);
  _set_fx_rom(48,  eDT_Vert, 4096,  0,     512,  0,     0,     0,     2);
  _set_fx_rom(49,  eDT_Vert, 8192,  0,     512,  0,     0,     0,     2);
  _set_fx_rom(50,  eDT_Vert, 16384, 0,     512,  0,     0,     0,     2);
  _set_fx_rom(51,  eDT_Vert, 2048,  0,     256,  0,     0,     0,     2);
  _set_fx_rom(52,  eDT_Vert, 4096,  0,     256,  0,     0,     0,     2);
  _set_fx_rom(53,  eDT_Vert, 8192,  0,     256,  0,     0,     0,     2);
  _set_fx_rom(54,  eDT_Vert, 16384, 0,     256,  0,     0,     0,     2);
  _set_fx_rom(55,  eDT_Vert, 32768, 0,     1024, 0,     0,     0,     2);
  _set_fx_rom(56,  eDT_Vert, 32768, 0,     512,  0,     0,     0,     2);
  _set_fx_rom(57,  eDT_Vert, 65535, 0,     512,  0,     0,     0,     2);
  _set_fx_rom(58,  eDT_Rand, 2048,  0,     1024, 0,     0,     0,     2); // f4
  _set_fx_rom(59,  eDT_Rand, 4096,  0,     1024, 0,     0,     0,     2); // f4
  _set_fx_rom(60,  eDT_Rand, 8192,  0,     1024, 0,     0,     0,     2); // f4
  _set_fx_rom(61,  eDT_Rand, 16384, 0,     1024, 0,     0,     0,     2); // f4
  _set_fx_rom(62,  eDT_Rand, 2048,  0,     768,  0,     0,     0,     2); // f4
  _set_fx_rom(63,  eDT_Rand, 4096,  0,     768,  0,     0,     0,     2); // f4
  _set_fx_rom(64,  eDT_Rand, 8192,  0,     768,  0,     0,     0,     2); // f4
  _set_fx_rom(65,  eDT_Rand, 16384, 0,     768,  0,     0,     0,     2); // f4
  _set_fx_rom(66,  eDT_Rand, 2048,  0,     512,  0,     0,     0,     2); // f4
  _set_fx_rom(67,  eDT_Rand, 4096,  0,     512,  0,     0,     0,     2); // f4
  _set_fx_rom(68,  eDT_Rand, 8192,  0,     512,  0,     0,     0,     2); // f4
  _set_fx_rom(69,  eDT_Rand, 16384, 0,     512,  0,     0,     0,     2); // f4
  _set_fx_rom(70,  eDT_Rand, 2048,  0,     256,  0,     0,     0,     2); // f4
  _set_fx_rom(71,  eDT_Rand, 4096,  0,     256,  0,     0,     0,     2); // f4
  _set_fx_rom(72,  eDT_Rand, 8192,  0,     256,  0,     0,     0,     2); // f4
  _set_fx_rom(73,  eDT_Rand, 16384, 0,     256,  0,     0,     0,     2); // f4
  _set_fx_rom(74,  eDT_Rand, 32768, 0,     1024, 0,     0,     0,     2); // f4
  _set_fx_rom(75,  eDT_Rand, 32768, 0,     512,  0,     0,     0,     2); // f4
  _set_fx_rom(76,  eDT_Rand, 65535, 0,     512,  0,     0,     0,     2); // f4
  _set_fx_rom(77,  eDT_Rand, 8192,  256,   512,  0,     0,     0,     10); // f4
  _set_fx_rom(78,  eDT_Hori, 8192,  256,   512,  0,     0,     0,     10);
  _set_fx_rom(79,  eDT_HInt, 8192,  256,   512,  0,     0,     0,     10);
  _set_fx_rom(80,  eDT_Vert, 8192,  256,   512,  0,     0,     0,     10);
  _set_fx_rom(81,  eDT_Vert, 0,     256,   512,  0,     0,     0,     0);
  _set_fx_rom(82,  eDT_Vert, 65280, 65280, 512,  0,     0,     0,     0);
  _set_fx_rom(83,  eDT_Hori, 0,     256,   512,  0,     0,     0,     0);
  _set_fx_rom(84,  eDT_Hori, 65280, 65280, 512,  0,     0,     0,     0);
  _set_fx_rom(85,  eDT_Vert, 32768, 0,     512,  0,     512,   0,     0);
  _set_fx_rom(86,  eDT_Vert, 32768, 0,     512,  0,     128,   0,     0);
  _set_fx_rom(87,  eDT_Vert, 16384, 0,     1024, 0,     256,   2,     0);
  _set_fx_rom(88,  eDT_Vert, 16384, 0,     1024, 0,     768,   65534, 0);
  _set_fx_rom(89,  eDT_Hori, 16384, 0,     2048, 65534, 0,     0,     1);
  _set_fx_rom(90,  eDT_Hori, 16384, 0,     0,    2,     0,     0,     255);
  _set_fx_rom(91,  eDT_Vert, 0,     0,     0,    0,     256,   3,     0);
  _set_fx_rom(92,  eDT_Vert, 0,     0,     0,    0,     2056,  65533, 0);
  _set_fx_rom(93,  eDT_Vert, 0,     0,     0,    0,     512,   65535, 0);
  _set_fx_rom(94,  eDT_Vert, 0,     0,     0,    0,     0,     1,     0);
  _set_fx_rom(95,  eDT_Vert, 0,     0,     0,    0,     736,   65534, 0);
  _set_fx_rom(96,  eDT_Vert, 0,     0,     0,    0,     0,     2,     0);
  _set_fx_rom(97,  eDT_Hori, 32768, 65436, 1024, 65534, 0,     0,     1);
  _set_fx_rom(98,  eDT_Hori, 8768,  100,   544,  2,     0,     0,     255);
  _set_fx_rom(99,  eDT_Rand, 16384, 0,     512,  2,     256,   2,     1); // f4
  _set_fx_rom(100, eDT_Rand, 16384, 0,     1024, 65534, 768,   65534, 255); // f4
  _set_fx_rom(101, eDT_Hori, 2048,  0,     128,  0,     0,     0,     0);
  _set_fx_rom(102, eDT_Hori, 0,     128,   1024, 0,     0,     0,     0);
  _set_fx_rom(103, eDT_Hori, 32768, 65408, 1024, 0,     0,     0,     0);
  _set_fx_rom(104, eDT_Hori, 0,     128,   512,  0,     0,     0,     0);
  _set_fx_rom(105, eDT_Hori, 64000, 65408, 512,  0,     0,     0,     0);
  _set_fx_rom(106, eDT_Hori, 0,     80,    512,  0,     0,     0,     0);
  _set_fx_rom(107, eDT_Hori, 40000, 65456, 512,  0,     0,     0,     0);
  _set_fx_rom(108, eDT_Vert, 2048,  0,     512,  0,     0,     1,     0);
  _set_fx_rom(109, eDT_Vert, 2048,  0,     512,  0,     61440, 65534, 0);
  _set_fx_rom(110, eDT_Hori, 0,     0,     0,    0,     0,     0,     0);
  _set_fx_rom(111, eDT_Hori, 0,     0,     0,    0,     0,     0,     0);
  _set_fx_rom(112, eDT_Hori, 0,     128,   256,  0,     0,     0,     0);
  _set_fx_rom(113, eDT_Hori, 0,     64,    256,  0,     0,     0,     0);
  _set_fx_rom(114, eDT_HInt, 64128, 0,     4096, 0,     0,     0,     0);
  _set_fx_rom(115, eDT_HInt, 4096,  0,     512,  0,     0,     0,     2);
  _set_fx_rom(116, eDT_Hori, 4096,  0,     512,  0,     0,     0,     2);
  _set_fx_rom(117, eDT_Vert, 4096,  0,     224,  0,     0,     0,     2);
  _set_fx_rom(118, eDT_Vert, 0,     128,   1024, 0,     0,     0,     0);
  _set_fx_rom(119, eDT_Vert, 32768, 65408, 1024, 0,     0,     0,     0);
  _set_fx_rom(120, eDT_Vert, 1024,  0,     512,  0,     256,   2,     0);
  _set_fx_rom(121, eDT_Vert, 1024,  0,     512,  0,     1216,  65534, 0);
  _set_fx_rom(122, eDT_Vert, 16384, 0,     768,  0,     0,     0,     2);
  _set_fx_rom(123, eDT_Vert, 8192,  0,     1024, 0,     0,     0,     2);
  _set_fx_rom(124, eDT_Vert, 0,     128,   1024, 0,     0,     0,     0);
  _set_fx_rom(125, eDT_Vert, 32768, 65408, 1024, 0,     0,     0,     0);
  _set_fx_rom(126, eDT_Vert, 0,     150,   1024, 0,     0,     0,     0);
  _set_fx_rom(127, eDT_Vert, 38400, 65386, 1024, 0,     0,     0,     0);
  _set_fx_rom(128, eDT_Rand, 0,     60,    256,  0,     0,     0,     2); // f4
  _set_fx_rom(129, eDT_Rand, 21600, 65476, 256,  0,     0,     0,     2); // f4
  _set_fx_rom(130, eDT_Vert, 1024,  0,     256,  0,     0,     0,     2);
  _set_fx_rom(131, eDT_Rand, 0,     90,    256,  0,     0,     0,     2); // f4
  _set_fx_rom(132, eDT_Rand, 21600, 65446, 256,  0,     0,     0,     2); // f4
  _set_fx_rom(133, eDT_Vert, 0,     128,   512,  0,     0,     0,     0);
  _set_fx_rom(134, eDT_Vert, 65280, 65408, 512,  0,     0,     0,     0);
}

int _distorter(int y, int t, DistCfg* dist_cfg)
{
  float C1 = _d_c1;
  float C2 = _d_c2;
  float C3 = _d_c3;

  DistType distortEffect = dist_cfg.type;
  float ampl = dist_cfg.ampl;
  float ampl_accel = dist_cfg.ampl_accel;
  float s_freq = dist_cfg.s_freq;
  float s_freq_accel = dist_cfg.s_freq_accel;
  float compr = dist_cfg.compr;
  float compr_accel = dist_cfg.compr_accel;
  float speed = dist_cfg.speed;

  float ft = IntToFloat(t);
  float fy = IntToFloat(y);

  // Compute "current" values of amplitude, frequency, and compression
  float amplitude = (ampl + ampl_accel * ft * 2.0);
  float frequency = (s_freq + s_freq_accel * ft * 2.0);
  float compression = (compr + compr_accel * ft * 2.0);

 // String str_kangle = String.Format(D_FORMAT_FIX, (C2 * frequency * fy + C3 * speed * ft));
  float kangle = C2 * frequency * fy + C3 * speed * ft;//str_kangle.AsFloat;

  // Compute the value of the sinusoidal line offset function
  int S = FloatToInt(C1 * amplitude * Maths.Sin(kangle));

  if(distortEffect == eDT_Rand) {
    distortEffect = FloatToInt(4.0+4.0*Maths.Sin(IntToFloat(t%64)/32.0))%3 + 1;
  }

  if (distortEffect == eDT_Hori) {
    return S;
  } else if (distortEffect == eDT_HInt) {
    if((y % 2) == 0) {
      return -S;
    } else {
      return S;
    }
  } else if (distortEffect == eDT_Vert) {
    int L = FloatToInt(fy * (1.0 + compression / 256.0) + IntToFloat(S), eRoundDown) % 256;
    if (L < 0) L = 256 + L;
    if (L > 255) L = 256 - L;

    return L;
  }

  return 0;
}

void _compute_frame(DrawingSurface* dst, DrawingSurface* src, int transparency, int letterbox, int ticks, DistCfg* dist_cfg, int tile_w, int tile_h)
{
  int w = dst.Width - tile_w + 2;
  int h = dst.Height - dst.Height%tile_h + 2;
  #ifndef SCRIPT_API_v360
  h -= 2;
  #endif
  int S, L;
  DistType distortEffect = dist_cfg.type;

  if(distortEffect == eDT_Rand) {
    distortEffect = (ticks/2)%3 + 1;
  }

  for (int y = 0; y < h; y+= tile_h) {
    S = _distorter(y, ticks, dist_cfg);
    L = y;

    if (distortEffect == eDT_Vert) {
      L = S;
    }

    //if (y < letterbox || y > w - letterbox) {
    //  continue;
    //}

    for (int x = 0; x < w; x+= tile_w) {
      int dx = x;

      if (distortEffect == eDT_Hori || distortEffect == eDT_HInt) {
        dx = (x + S) % 256;
        if (dx < 0) dx = 256 + dx;
        if (dx > 255) dx = 256 - dx;
      }

      #ifdef SCRIPT_API_v360
      dst.DrawSurface(src, transparency, x, y, tile_w, tile_h, dx, L, tile_w, tile_h);
      #endif
      #ifndef SCRIPT_API_v360
      DynamicSprite* tmp = DynamicSprite.CreateFromDrawingSurface(src, dx, L, tile_w, tile_h);
      dst.DrawImage(x, y, tmp.Graphic, transparency, tile_w, tile_h);
      tmp.Delete();
      #endif
    }
  }
}

// ------------------------------------------------------------------------------------------------
// Public API
// ------------------------------------------------------------------------------------------------

void DistFX::Update(DrawingSurface* source, DrawingSurface* dest, int effect)
{
  if(effect != this._prev_fx) this._ticks = 0; // reset ticks on effect change

  if(this._tile_width <= 0) { this._tile_width = 64; }
  if(this._tile_height <= 0) { this._tile_height = 1; }

  _compute_frame(dest, source, this._drawing_transparency, 0, this._ticks, _fx_rom[effect], this._tile_width, this._tile_height);

  if(this._ticks < 0) {
    this._reverse_ticks = false;
  } else if(this._ticks > 4096) {
    this._reverse_ticks = true;
  }

  if(this._reverse_ticks) {
    this._ticks-=1;
  } else {
    this._ticks++;
  }
  this._prev_fx = effect;
}

void DistFX::Reset()
{
  this._ticks = 0; // reset tick
}

int DistFX::get_DrawingTransparency()
{
  return this._drawing_transparency;
}

void DistFX::set_DrawingTransparency(int value)
{
  if(value > 99) value = 99;
  if(value < 0) value = 0;
  this._drawing_transparency = value;
}

int DistFX::get_TileWidth()
{
  return this._tile_width;
}

void DistFX::set_TileWidth(int value)
{
  if(value > 256) value = 256;
  if(value < 1) value = 1;
  this._tile_width = value;
}

int DistFX::get_TileHeight()
{
  return this._tile_height;
}

void DistFX::set_TileHeight(int value)
{
  if(value > 128) value = 128;
  if(value < 1) value = 1;
  this._tile_height = value;
}

// ------------------------------------------------------------------------------------------------
// Events and hooks
// ------------------------------------------------------------------------------------------------

void game_start()
{
  _distfx_init();
}
 �  // DistFX Module Header
// Version 0.2.0

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
 $.        fj����  ej��