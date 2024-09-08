Shader "Custom/Barbarian Body"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RampTex("Ramp Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf _Ramp noambient

        sampler2D _MainTex;
        sampler2D _RampTex;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_RampTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D (_RampTex, IN.uv_RampTex);

            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

        float4 Lighting_Ramp(SurfaceOutput s, float3 lightDir, float atten)
        {
            float4 ndotl = dot (s.Normal, lightDir) * 0.5 + 0.5;

            float3 rampColor = tex2D(_RampTex, float2(ndotl.x, 0));

            return float4(rampColor * s.Albedo, 1);
        }

        ENDCG
    }
    FallBack "Diffuse"
}
