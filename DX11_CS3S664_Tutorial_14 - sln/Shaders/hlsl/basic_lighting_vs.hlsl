

// Ensure matrices are row-major
#pragma pack_matrix(row_major)

//----------------------------
// Input / Output structures
//----------------------------
struct vertexInputPacket {

	float3				pos			: POSITION;
	float3				normal		: NORMAL;
	float4				matDiffuse	: DIFFUSE;
	float4				matSpecular	: SPECULAR;
	float2				texCoord	: TEXCOORD;
};


struct vertexOutputPacket {

	float4				colour		: COLOR;
	float4				posH			: SV_POSITION;
};

cbuffer basicCBuffer : register(b0) {

	float4x4	worldViewProjMatrix;
	float4x4	worldITMatrix;
	float3		lightDir;

};


//
// Vertex shader
//
vertexOutputPacket main(vertexInputPacket inputVertex) {

	vertexOutputPacket outputVertex;

	// Lighting is calculated in world space.
	// Transform normals to world space with worldITMatrix.
	float3 norm = normalize(mul(float4(inputVertex.normal, 1.0f), worldITMatrix).xyz);
	// To Do: Edit the code below to output the lit vertex colour
	// For a basic diffuse directional light - lit_colour = vertex_diffuse_colour*dot_product(notrmalised_vertex_normal, normalised_light_direction)
	outputVertex.colour = inputVertex.matDiffuse; 
	// Transformation of vertex position from "3d model space" into 2d "screen space"
	outputVertex.posH = mul(float4(inputVertex.pos, 1.0), worldViewProjMatrix);
	return outputVertex;
}
