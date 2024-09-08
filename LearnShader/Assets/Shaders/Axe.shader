Shader "Custom/Axe"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _SpecColor ("SpecColor", Color) = (1,1,1,1)
        _Specular("Specular", Range(0,1)) = 0.5
        _Gloss ("Gloss", Range(0,10)) = 0
        _AmbientOcclusion ("AmbientOcclusion", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        #pragma surface surf BlinnPhong

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _AmbientOcclusion;
        float _Specular;
        float _Gloss;

        struct Input
        {
            float2 uv_MainTex;
            float4 color:COLOR;
            float2 uv_AmbientOcclusion;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);

            fixed4 occlusionColor = tex2D(_AmbientOcclusion, IN.uv_AmbientOcclusion);

            o.Albedo = lerp(IN.color.rgb, c.rgb, IN.color.r);
                   
            o.Gloss = lerp(0, 1, IN.color.r);
            o.Alpha = o.Alpha;

            o.Specular = 0.4;

        }
        ENDCG
    }
    FallBack "Diffuse"
}
