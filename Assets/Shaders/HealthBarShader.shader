Shader "Unlit/HealthBarShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Health ("Health", Range(0,1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            //float _Health;

            UNITY_INSTANCING_BUFFER_START(Props)
                UNITY_DEFINE_INSTANCED_PROP(float, _Health) //Make health an instanced property (ie an array)
            UNITY_INSTANCING_BUFFER_END(Props)

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                UNITY_SETUP_INSTANCE_ID(i);
                float health = UNITY_ACCESS_INSTANCED_PROP(_Health_arr, _Health);

                float3 healthbarColor = lerp(float3(1,0,0),float3(0,1,0),health);
                float3 bgColor = (0.1).xxx;
                
                //float healthbarMask = health > floor(i.uv.x * 8)/8;
                float healthbarMask = health > i.uv.x;
                //healthbarColor *= healthbarMask;

                float3 outColor = lerp(bgColor, healthbarColor, healthbarMask);
                
                return float4(outColor,1);
            }
            ENDCG
        }
    }
}

//Mathf.Lerp()  //Clamped
//lerp()        //Unclamped
//Clamp01() --> Saturate()