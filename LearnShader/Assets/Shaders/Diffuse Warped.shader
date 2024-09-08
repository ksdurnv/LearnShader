Shader "Custom/Diffuse Warped"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RampTex("Ramp Texture", 2D) = "white" {}
        _Slide1("_Slide1", Range(0,1)) = 0
        _Slide2("_Slide2", Range(0,1)) = 0
        _Slide3("_Slide3", Range(0,1)) = 0
        _Slide4("_Slide4", Range(0,1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf _Warp noambient

        sampler2D _MainTex;
        sampler2D _RampTex;
        float _Slide1;
        float _Slide2;
        float _Slide3;
        float _Slide4;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

        float4 Lighting_Warp(SurfaceOutput s, float3 lightDir, float atten) {
            float ndotl = dot(s.Normal, lightDir) * 0.5 + 0.5;

            if(ndotl < _Slide1) 
            {
                ndotl = 0.1;
            }
            if(ndotl >= _Slide1 && ndotl < _Slide2) 
            {
                ndotl *= 0.3;
            }
            if(ndotl >= _Slide2 && ndotl < _Slide3) 
            {
                ndotl *= 0.5;
            }
            if(ndotl >= _Slide3 && ndotl < _Slide4) 
            {
                ndotl *= 0.7;
            }


            float4 ramp = tex2D(_RampTex, float2(ndotl, 0.5));
            return ramp;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
